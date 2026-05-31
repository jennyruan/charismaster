#!/usr/bin/env bash
# scripts/deploy.sh — deploy Charismaster to Google Cloud Run.
#
# Prereqs (one-time):
#   gcloud auth login
#   gcloud config set project <PROJECT_ID>
#   gcloud services enable run.googleapis.com cloudbuild.googleapis.com artifactregistry.googleapis.com
#   export GEMINI_API_KEY=...   # in your shell, not committed
#
# Run:
#   bash scripts/deploy.sh
#
# Override defaults via env:
#   SERVICE=charismaster REGION=us-central1 MEMORY=2Gi TIMEOUT=300 bash scripts/deploy.sh
set -euo pipefail

cd "$(dirname "$0")/.."

SERVICE="${SERVICE:-charismaster}"
REGION="${REGION:-us-central1}"
MEMORY="${MEMORY:-2Gi}"
CPU="${CPU:-1}"
TIMEOUT="${TIMEOUT:-300}"
MAX_INSTANCES="${MAX_INSTANCES:-3}"
GEMINI_MODEL="${GEMINI_MODEL:-gemini-2.0-flash-exp}"

if ! command -v gcloud >/dev/null 2>&1; then
  echo "✗ gcloud not found. Install: https://cloud.google.com/sdk/docs/install" >&2
  exit 1
fi

PROJECT=$(gcloud config get-value project 2>/dev/null || true)
if [[ -z "$PROJECT" || "$PROJECT" == "(unset)" ]]; then
  echo "✗ no gcloud project set. Run: gcloud config set project <PROJECT_ID>" >&2
  exit 1
fi

if [[ -z "${GEMINI_API_KEY:-}" ]]; then
  echo "✗ GEMINI_API_KEY not set in environment." >&2
  echo "   Run:  export GEMINI_API_KEY=...   (in your shell)" >&2
  exit 1
fi

echo "→ deploying $SERVICE to Cloud Run"
echo "  project:  $PROJECT"
echo "  region:   $REGION"
echo "  memory:   $MEMORY  cpu: $CPU  timeout: ${TIMEOUT}s  max-instances: $MAX_INSTANCES"
echo

gcloud run deploy "$SERVICE" \
  --source . \
  --region "$REGION" \
  --platform managed \
  --allow-unauthenticated \
  --memory "$MEMORY" \
  --cpu "$CPU" \
  --timeout "$TIMEOUT" \
  --max-instances "$MAX_INSTANCES" \
  --set-env-vars "GEMINI_API_KEY=${GEMINI_API_KEY},GEMINI_MODEL=${GEMINI_MODEL}" \
  --quiet

URL=$(gcloud run services describe "$SERVICE" --region "$REGION" --format='value(status.url)')
echo
echo "✓ deployed:  $URL"
echo
echo "  smoke test it:"
echo "    BASE_URL=$URL bash scripts/smoke.sh"
