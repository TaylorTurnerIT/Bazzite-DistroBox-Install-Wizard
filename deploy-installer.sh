#!/bin/bash

# Configuration
SCRIPT_NAME="universal-installer.sh"
DESKTOP_NAME="universal-installer.desktop"

TARGET_BIN="$HOME/.local/bin"
TARGET_APP="$HOME/.local/share/applications"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "🚀 ${GREEN}Deploying Universal Installer...${NC}"

# 1. Ensure target directories exist
mkdir -p "$TARGET_BIN"
mkdir -p "$TARGET_APP"

# 2. Deploy the Script
if [ -f "./$SCRIPT_NAME" ]; then
    echo "Copying script to $TARGET_BIN..."
    cp "./$SCRIPT_NAME" "$TARGET_BIN/$SCRIPT_NAME"
    chmod +x "$TARGET_BIN/$SCRIPT_NAME"
    echo -e "✅ Script installed."
else
    echo -e "${RED}❌ Error: Could not find $SCRIPT_NAME in current folder.${NC}"
    exit 1
fi

# 3. Deploy the Desktop Shortcut
if [ -f "./$DESKTOP_NAME" ]; then
    echo "Copying shortcut to $TARGET_APP..."
    cp "./$DESKTOP_NAME" "$TARGET_APP/$DESKTOP_NAME"
    
    # Update database so the system sees the new file type association immediately
    update-desktop-database "$TARGET_APP"
    echo -e "✅ Desktop shortcut installed."
else
    echo -e "${RED}❌ Error: Could not find $DESKTOP_NAME in current folder.${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}Deployment Complete!${NC}"
echo "You can now double-click .deb and .rpm files to install them."