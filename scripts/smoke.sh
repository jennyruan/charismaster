#!/usr/bin/env bash
# scripts/smoke.sh — end-to-end smoke test against a running Charismaster server.
#
# Defaults to http://localhost:3000. Override with BASE_URL env:
#   BASE_URL=https://charismaster-xyz.run.app bash scripts/smoke.sh
#
# Defaults the test video to Sam Altman's "How to Pitch a Startup" (1m intro),
# mode = pitch. Override with VIDEO_URL and MODE env if needed.
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:3000}"
VIDEO_URL="${VIDEO_URL:-https://www.youtube.com/watch?v=oWZbWzAyHAE}"
MODE="${MODE:-pitch}"
POLL_INTERVAL="${POLL_INTERVAL:-3}"
MAX_WAIT_SECS="${MAX_WAIT_SECS:-180}"

if ! command -v curl >/dev/null 2>&1; then
  echo "✗ curl not found" >&2; exit 1
fi
if ! command -v jq >/dev/null 2>&1; then
  echo "✗ jq not found. Install: brew install jq" >&2; exit 1
fi

echo "→ POST $BASE_URL/api/analyze  (mode=$MODE)"
echo "  video: $VIDEO_URL"

POST_RES=$(curl -sS -X POST "$BASE_URL/api/analyze" \
  -H "content-type: application/json" \
  -d "$(jq -n --arg v "$VIDEO_URL" --arg m "$MODE" '{videoUrl:$v, mode:$m}')")

ID=$(echo "$POST_RES" | jq -r '.id // empty')
if [[ -z "$ID" ]]; then
  echo "✗ no id in response:" >&2
  echo "$POST_RES" | jq . >&2
  exit 1
fi
echo "  id: $ID"

echo "→ polling GET $BASE_URL/api/analyze?id=$ID  (every ${POLL_INTERVAL}s, max ${MAX_WAIT_SECS}s)"
ELAPSED=0
while (( ELAPSED < MAX_WAIT_SECS )); do
  GET_RES=$(curl -sS "$BASE_URL/api/analyze?id=$ID")
  STATUS=$(echo "$GET_RES" | jq -r '.status // "unknown"')
  printf "  [%3ds] status=%s\n" "$ELAPSED" "$STATUS"

  case "$STATUS" in
    done)
      echo "✓ analysis complete:"
      echo "$GET_RES" | jq '.report'
      exit 0
      ;;
    error)
      echo "✗ analysis errored:" >&2
      echo "$GET_RES" | jq '.error' >&2
      exit 1
      ;;
    pending)
      sleep "$POLL_INTERVAL"
      ELAPSED=$(( ELAPSED + POLL_INTERVAL ))
      ;;
    *)
      echo "✗ unexpected status: $STATUS" >&2
      echo "$GET_RES" | jq . >&2
      exit 1
      ;;
  esac
done

echo "✗ timed out after ${MAX_WAIT_SECS}s" >&2
exit 1
