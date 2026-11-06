#!/usr/bin/env bash
# Starts the API, runs both collections, stops the API. Handy for rehearsing.
set -uo pipefail
cd "$(dirname "$0")/.."
node src/server.js & SERVER_PID=$!
trap 'kill $SERVER_PID 2>/dev/null' EXIT
for i in $(seq 1 20); do curl -sf localhost:3000/health >/dev/null && break; sleep 0.5; done
echo "=== UNHELPFUL message ==="; npm run -s test:unhelpful
echo; echo "=== HELPFUL message ===";  npm run -s test:helpful
