#!/usr/bin/env bash
# Build script for JGWill VSCode fork

set -uo pipefail
LOG_FILE="build.log"

# Ensure dependencies are installed
if [ ! -d node_modules ]; then
  echo "node_modules missing, running npm install..." | tee "$LOG_FILE"
  npm install --omit=optional >>"$LOG_FILE" 2>&1
fi

# Ensure gulp is available
if [ ! -f node_modules/gulp/bin/gulp.js ]; then
  echo "gulp not found locally, using npx" | tee -a "$LOG_FILE"
  GULP_CMD="npx --yes gulp"
else
  GULP_CMD="node ./node_modules/gulp/bin/gulp.js"
fi

{
  echo "Starting build $(date)"
  $GULP_CMD compile
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
