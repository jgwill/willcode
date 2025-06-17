#!/usr/bin/env bash
# Setup script for JGWill VSCode fork
# Installs Node using nvm and installs dependencies
set -e

echo "Installing build dependencies"
sudo apt-get update -y >/dev/null
sudo apt-get install -y libkrb5-dev libxkbfile-dev >/dev/null

NODE_VERSION="$(cat .nvmrc)"
if ! command -v nvm >/dev/null 2>&1; then
  echo "nvm not found. Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  # shellcheck source=/dev/null
  source "$HOME/.nvm/nvm.sh"
fi
nvm install "$NODE_VERSION"
nvm use "$NODE_VERSION"

echo "Updating git submodules"
git submodule update --init --recursive

echo "Installing npm dependencies"
  npm install || echo "npm install encountered issues"

echo "Setup complete. Run ./JGWILL_BUILD.sh to build"
