#!/usr/bin/env bash
# scripts/setup.sh — local dev one-liner for Charismaster.
# Run from repo root:   bash scripts/setup.sh
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v pnpm >/dev/null 2>&1; then
  echo "✗ pnpm not found. Install: npm i -g pnpm" >&2
  exit 1
fi

if [[ ! -f package.json ]]; then
  echo "✗ package.json missing — A's scaffold hasn't landed yet. Re-run after A pushes." >&2
  exit 1
fi

echo "→ pnpm install"
pnpm install

if [[ ! -f .env.local ]]; then
  if [[ -f .env.example ]]; then
    cp .env.example .env.local
    echo "→ created .env.local from .env.example"
  else
    echo "GEMINI_API_KEY=" > .env.local
    echo "→ created empty .env.local"
  fi
fi

if ! grep -q '^GEMINI_API_KEY=.\+' .env.local 2>/dev/null; then
  echo
  echo "⚠  GEMINI_API_KEY is empty in .env.local."
  echo "   Get a key: https://aistudio.google.com/app/apikey"
  echo "   Then:     edit .env.local and paste it."
  echo
fi

echo "✓ setup complete. Next: pnpm dev"
