#!/usr/bin/env bash
# Install external tools required by this Emacs configuration.
# Run once on a new machine: ./install-tools.sh

set -e

if ! command -v uv >/dev/null 2>&1; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

echo "Installing Python tools..."
uv tool install basedpyright
uv tool install ruff

echo ""
echo "Installing C/C++ tools..."
if command -v clangd >/dev/null 2>&1 && command -v clang-format >/dev/null 2>&1; then
    echo "  clangd and clang-format already installed, skipping."
elif [[ "$(uname)" == "Darwin" ]]; then
    echo "  brew install llvm (provides clangd and clang-format)"
    brew install llvm
elif command -v apt-get >/dev/null 2>&1; then
    echo "  apt install clangd clang-format"
    sudo apt-get install -y clangd clang-format
elif command -v pacman >/dev/null 2>&1; then
    echo "  pacman -S clang"
    sudo pacman -S --needed clang
else
    echo "  Please install clangd and clang-format manually."
fi

echo ""
echo "Done. Ensure ~/.local/bin is in your PATH."
