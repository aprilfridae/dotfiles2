#!/bin/bash

# 1. Configuration
WALL_DIR="$HOME/Walls"

# 2. Get Selection from Walker
# We list files, strip the path for a cleaner menu, and pipe to walker
SELECTED=$(ls "$WALL_DIR" | grep -E '\.(jpg|jpeg|png|webp)$' | walker --dmenu)

# 3. Execution
if [ -n "$SELECTED" ]; then
    # Pass the full path to the sync engine
    bash "$HOME/.config/hypr/scripts/ocean.sh" "$WALL_DIR/$SELECTED"
fi