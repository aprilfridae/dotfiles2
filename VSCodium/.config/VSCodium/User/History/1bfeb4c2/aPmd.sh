#!/bin/bash

# Define paths (Adjust 'river' to your username)
MATUGEN_JSON="$HOME/.cache/matugen/colors-codium.json"
CODIUM_SETTINGS="$HOME/.config/VSCodium/User/settings.json"

# Check if Matugen has generated the colors yet
if [ ! -f "$MATUGEN_JSON" ]; then
    echo "Matugen colors not found. Run matugen first."
    exit 1
fi

# Extract colors using jq
PRIMARY=$(jq -r '.primary' "$MATUGEN_JSON")
BG=$(jq -r '.background' "$MATUGEN_JSON")
SECONDARY=$(jq -r '.secondary' "$MATUGEN_JSON")

# Use 'sed' to replace the colors in your settings.json
# This assumes you have the 'workbench.colorCustomizations' block already
sed -i "s/\"editor.background\": \".*\"/\"editor.background\": \"$BG\"/" "$CODIUM_SETTINGS"
sed -i "s/\"statusBar.background\": \".*\"/\"statusBar.background\": \"$PRIMARY\"/" "$CODIUM_SETTINGS"
sed -i "s/\"tab.activeBorder\": \".*\"/\"tab.activeBorder\": \"$PRIMARY\"/" "$CODIUM_SETTINGS"

echo "VSCodium colors synced!"