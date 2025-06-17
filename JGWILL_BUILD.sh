#!/usr/bin/env bash
# Build script for JGWill VSCode fork

set -uo pipefail
LOG_FILE="build.log"

# Ensure dependencies are installed
if [ ! -d node_modules ]; then
  echo "node_modules missing, running npm install..." | tee "$LOG_FILE"
  npm install >>"$LOG_FILE" 2>&1
fi

{
  echo "Starting build $(date)"
  npm run compile
} 2>&1 | tee "$LOG_FILE"

BUILD_STATUS=${PIPESTATUS[0]}
if [ "$BUILD_STATUS" -ne 0 ]; then
  echo "Build failed with status $BUILD_STATUS" | tee -a "$LOG_FILE"
  if command -v coaia >/dev/null 2>&1; then
    coaia tash Workspace.jgwill.willcode:codex.local-build-failure-logs -F "$LOG_FILE" -T 1000
  else
    echo "coaia command not found; cannot upload log" >> "$LOG_FILE"
  fi
  exit $BUILD_STATUS
fi

echo "Build finished successfully" | tee -a "$LOG_FILE"
