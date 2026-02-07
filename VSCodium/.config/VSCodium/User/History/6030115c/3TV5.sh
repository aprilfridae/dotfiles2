#!/bin/bash
# Asahi-friendly screenshot script
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
NAME="$DIR/screenshot_$(date +%Y%m%d_%H%M%S).png"

# Select region and pipe to swappy for editing
grim -g "$(slurp)" - | swappy -f - -o "$NAME"

# Copy the final saved file to clipboard
if [ -f "$NAME" ]; then
    wl-copy < "$NAME"
    notify-send "Screenshot Saved" "Saved to $NAME and copied to clipboard"
fi