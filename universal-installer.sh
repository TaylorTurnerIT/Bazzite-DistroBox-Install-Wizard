#!/bin/bash

# --- Bazzite Universal Distrobox Installer v2 ---

FILE_PATH="$1"
FILENAME=$(basename "$FILE_PATH")
EXTENSION="${FILENAME##*.}"
TEMP_TRACKER="$HOME/.distrobox_last_installed"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Clear previous tracker
rm -f "$TEMP_TRACKER"

echo -e "${BLUE}📦 Universal Installer Wizard${NC}"
echo "Processing: $FILENAME"

# --- Logic: Select Container ---

if [[ "$EXTENSION" == "deb" ]]; then
    CONTAINER_NAME="deb-installer"
    DISTRO_IMAGE="debian:latest"
    echo -e "Type detected: ${GREEN}DEBIAN (.deb)${NC}"
    
    # 1. Update
    # 2. Install
    # 3. Identify Name & Write to tracker file (shared with host)
    # 4. Export
    INSTALL_CMD="
        sudo apt-get update; 
        echo '--- Installing Package... ---';
        sudo apt-get install -y \"$FILE_PATH\"; 
        PKG_NAME=\$(dpkg-deb -f \"$FILE_PATH\" Package);
        echo \$PKG_NAME > \"$TEMP_TRACKER\";
        echo '--- Exporting to Bazzite... ---';
        distrobox-export --app \$PKG_NAME;
    "

elif [[ "$EXTENSION" == "rpm" ]]; then
    CONTAINER_NAME="rpm-installer"
    DISTRO_IMAGE="fedora:latest"
    echo -e "Type detected: ${GREEN}RED HAT/FEDORA (.rpm)${NC}"

    INSTALL_CMD="
        echo '--- Installing Package... ---';
        sudo dnf install -y \"$FILE_PATH\";
        PKG_NAME=\$(rpm -qp --queryformat '%{NAME}' \"$FILE_PATH\");
        echo \$PKG_NAME > \"$TEMP_TRACKER\";
        echo '--- Exporting to Bazzite... ---';
        distrobox-export --app \$PKG_NAME;
    "

else
    echo "❌ Error: Unsupported file type (.$EXTENSION)"
    read -p "Press Enter to exit..."
    exit 1
fi

# --- Container Check ---

if ! distrobox list | grep -q "$CONTAINER_NAME"; then
    echo -e "Creating container '${CONTAINER_NAME}'..."
    distrobox create -n "$CONTAINER_NAME" -i "$DISTRO_IMAGE" -Y
fi

# --- Execution ---

echo -e "${BLUE}Starting Installation...${NC}"
distrobox enter "$CONTAINER_NAME" -- bash -c "$INSTALL_CMD"

# --- Post-Install Prompt ---

echo ""
if [ -f "$TEMP_TRACKER" ]; then
    INSTALLED_APP=$(cat "$TEMP_TRACKER")
    rm "$TEMP_TRACKER" # Cleanup
    
    echo -e "${GREEN}✅ Installation Complete: $INSTALLED_APP${NC}"
    echo -e "${YELLOW}What would you like to do?${NC}"
    echo "1) Launch $INSTALLED_APP now"
    echo "2) Close this window"
    
    read -p "Select [1/2]: " -n 1 -r REPLY
    echo "" # New line

    if [[ $REPLY =~ ^[1]$ ]]; then
        echo "🚀 Launching..."
        # Run in background so we can close the terminal
        nohup "$INSTALLED_APP" >/dev/null 2>&1 & 
        sleep 1
        exit 0
    else
        echo "Closing..."
        exit 0
    fi
else
    # Fallback if something failed and no app name was caught
    echo -e "${YELLOW}Installation finished, but could not detect app name to launch automatically.${NC}"
    read -p "Press Enter to close..."
fi