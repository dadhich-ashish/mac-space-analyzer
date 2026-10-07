#!/bin/bash

PROJECT_NAME="Mac Space Analyzer"
APP_VERSION="1.0.0"
DMG_NAME="MacSpaceAnalyzer-${APP_VERSION}.dmg"
TEMP_DMG="temp.dmg"
MOUNT_POINT="/Volumes/MacSpaceAnalyzer"

echo "🔨 Creating DMG installer for $PROJECT_NAME..."

if [ -f "$DMG_NAME" ]; then
    echo "Removing existing DMG..."
    rm -f "$DMG_NAME"
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMP_DIR=$(mktemp -d)
INSTALL_SOURCE="$TEMP_DIR/MacSpaceAnalyzer"

mkdir -p "$INSTALL_SOURCE"

cp -r "$SCRIPT_DIR"/*.js "$INSTALL_SOURCE/"
cp -r "$SCRIPT_DIR"/*.html "$INSTALL_SOURCE/"
cp -r "$SCRIPT_DIR"/*.json "$INSTALL_SOURCE/"
cp -r "$SCRIPT_DIR"/*.sh "$INSTALL_SOURCE/"
mkdir -p "$INSTALL_SOURCE/node_modules"
cp -r "$SCRIPT_DIR/node_modules" "$INSTALL_SOURCE/" 2>/dev/null || true

SIZE=$(du -sh "$TEMP_DIR" | awk '{print $1}' | sed 's/M//')
SIZE=$((${SIZE%%.*} + 50))M

echo "📀 Creating disk image..."
hdiutil create -volname "$PROJECT_NAME" -srcfolder "$TEMP_DIR" -ov -format UDZO "$DMG_NAME" > /dev/null

echo "✅ DMG created: $DMG_NAME"
echo ""
echo "📦 Distribution:"
echo "   File: $DMG_NAME"
echo "   Version: $APP_VERSION"
echo ""
echo "🎯 Users can now:"
echo "   1. Download and open $DMG_NAME"
echo "   2. Double-click install.sh to install"
echo "   3. Run: space-analyzer or space-analyzer-web"
echo ""

rm -rf "$TEMP_DIR"
