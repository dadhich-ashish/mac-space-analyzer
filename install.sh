#!/bin/bash

set -e

INSTALL_DIR="$HOME/.local/opt/mac-space-analyzer"
BIN_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config/mac-space-analyzer"

echo "🚀 Installing Mac Space Analyzer..."
echo ""

if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    echo "   Visit: https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js found: $(node --version)"
echo ""

mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"
mkdir -p "$CONFIG_DIR"

echo "📦 Copying application files..."
cp -r . "$INSTALL_DIR/" 2>/dev/null || {
    echo "❌ Failed to copy files to $INSTALL_DIR"
    exit 1
}

cd "$INSTALL_DIR"

echo "📥 Installing dependencies..."
npm install --production > /dev/null 2>&1

echo "🔧 Creating command shortcuts..."

cat > "$BIN_DIR/space-analyzer" << 'EOF'
#!/bin/bash
node "$HOME/.local/opt/mac-space-analyzer/cli.js" "$@"
EOF

cat > "$BIN_DIR/space-analyzer-web" << 'EOF'
#!/bin/bash
node "$HOME/.local/opt/mac-space-analyzer/server.js"
EOF

chmod +x "$BIN_DIR/space-analyzer"
chmod +x "$BIN_DIR/space-analyzer-web"

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo "⚠️  Adding $HOME/.local/bin to PATH..."
    
    if [[ -f "$HOME/.zshrc" ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
        echo "✅ Updated .zshrc"
    fi
    
    if [[ -f "$HOME/.bash_profile" ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bash_profile"
        echo "✅ Updated .bash_profile"
    fi
    
    export PATH="$HOME/.local/bin:$PATH"
fi

echo ""
echo "✨ Installation complete!"
echo ""
echo "📝 Usage:"
echo "   space-analyzer                    # Analyze home directory (CLI)"
echo "   space-analyzer /path/to/folder    # Analyze specific folder (CLI)"
echo "   space-analyzer-web                # Start web interface (http://localhost:3000)"
echo ""
echo "🗑️  To uninstall, run: bash $INSTALL_DIR/uninstall.sh"
echo ""
