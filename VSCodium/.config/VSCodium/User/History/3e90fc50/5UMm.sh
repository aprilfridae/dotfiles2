#!/bin/bash

# 1. Setup paths
WALL_PATH=$(cat ~/.cache/.current_wallpaper 2>/dev/null || echo "$HOME/Pictures/wallpapers/default.jpg")
if [ -n "$1" ]; then
    WALL_PATH=$(realpath "$1")
    echo "$WALL_PATH" > ~/.cache/.current_wallpaper
fi

# 2. Set Wallpaper (Awww transition)
awww img "$WALL_PATH" --transition-type outer --transition-step 90 --transition-fps 120

# 3. Generate Colors (Vibrant Mode for real "Pop")
matugen image "$WALL_PATH" -m dark -s scheme-vibrant

# 4. Sync GTK (The xsettingsd Bell Ringer)
if command -v xsettingsd >/dev/null; then
    THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")
    echo "Net/ThemeName \"Adwaita\"" | timeout 0.1 xsettingsd
    echo "Net/ThemeName \"$THEME\"" | timeout 0.1 xsettingsd
fi

# 5. UI Core Reloads
# Ironbar (Combining Matugen colors with base layout)
cat ~/.cache/matugen/ironbar.css ~/.config/ironbar/base.css > ~/.config/ironbar/style.css
ironbar reload

# Hyprland (Borders & Window Rules)
hyprctl reload

# SwayNC (The fix: Reset config then Reload Style)
swaync-client -R
swaync-client -rs

# Spotify (Apply colors to the skin)
spicetify apply

# Walker (Restart service to pick up new CSS)
walker --gapplication-service --replace & disown

# 6. Zen Browser (Restarting for now to ensure sync)
pkill zen && zen & disown

notify-send -a "System" "Theme Synced" "$(basename "$WALL_PATH")"