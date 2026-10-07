#!/bin/bash

INSTALL_DIR="$HOME/.local/opt/mac-space-analyzer"
BIN_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config/mac-space-analyzer"

echo "🗑️  Uninstalling Mac Space Analyzer..."
echo ""

read -p "Are you sure you want to uninstall? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 1
fi

echo "Removing application files..."
rm -rf "$INSTALL_DIR"
rm -f "$BIN_DIR/space-analyzer"
rm -f "$BIN_DIR/space-analyzer-web"
rm -rf "$CONFIG_DIR"

if [[ -f "$HOME/.zshrc" ]]; then
    sed -i '' '/space-analyzer/d' "$HOME/.zshrc" 2>/dev/null || true
fi

if [[ -f "$HOME/.bash_profile" ]]; then
    sed -i '' '/space-analyzer/d' "$HOME/.bash_profile" 2>/dev/null || true
fi

echo "✅ Uninstalled successfully"
