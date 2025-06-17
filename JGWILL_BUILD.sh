#!/usr/bin/env bash
# Build script for JGWill VSCode fork

set -uo pipefail
LOG_FILE="build.log"

{
  echo "Starting build $(date)"
  npm run compile
} 2>&1 | tee "$LOG_FILE"

BUILD_STATUS=${PIPESTATUS[0]}
if [ "$BUILD_STATUS" -ne 0 ]; then
  echo "Build failed with status $BUILD_STATUS" | tee -a "$LOG_FILE"
  coaia tash Workspace.jgwill.willcode:codex.local-build-failure-logs -F "$LOG_FILE" -T 1000
  exit $BUILD_STATUS
fi

echo "Build finished successfully" | tee -a "$LOG_FILE"
