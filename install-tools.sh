#!/usr/bin/env bash
# Install external tools required by this Emacs configuration.
# Run once on a new machine: ./install-tools.sh

set -e

command -v uv >/dev/null 2>&1 || { echo "Error: uv not found. Install from https://docs.astral.sh/uv/"; exit 1; }

echo "Installing Python tools..."
uv tool install basedpyright
uv tool install ruff

echo "Done. Ensure ~/.local/bin is in your PATH."
