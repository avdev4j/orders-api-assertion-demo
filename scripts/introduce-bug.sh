#!/usr/bin/env bash
# Simulates the breaking change: the API starts returning "id" instead of "orderId".
# The OpenAPI spec still says "orderId", so the spec is the source of truth.
set -euo pipefail
cd "$(dirname "$0")/.."
sed -i.bak 's/orderId: "ord_123"/id: "ord_123"/' src/server.js
rm -f src/server.js.bak
git diff --stat src/server.js 2>/dev/null || true
echo "Bug introduced: the API now returns 'id' instead of 'orderId'."
