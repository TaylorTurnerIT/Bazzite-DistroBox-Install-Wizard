#!/bin/bash
set -e

# Configuration
INSTALLER_SCRIPT="universal-installer.sh"
TARGET_DIR="$HOME/.local/bin"

# Create the target directory and copy the installer script
echo "Installing $INSTALLER_SCRIPT to $TARGET_DIR/"
mkdir -p "$TARGET_DIR"
cp ./$INSTALLER_SCRIPT "$TARGET_DIR/$INSTALLER_SCRIPT"
chmod +x "$TARGET_DIR/$INSTALLER_SCRIPT"