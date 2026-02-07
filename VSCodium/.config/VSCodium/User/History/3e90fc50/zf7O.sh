#!/bin/bash

# 1. Path Logic
# Use the first argument if provided, otherwise fallback to the cache
if [ -n "$1" ]; then
    WALL_PATH=$(realpath "$1")
    echo "$WALL_PATH" > ~/.cache/.current_wallpaper
else
    WALL_PATH=$(cat ~/.cache/.current_wallpaper 2>/dev/null || echo "$HOME/Pictures/wallpapers/default.jpg")
fi

# 2. Wallpaper & Colors
awww img "$WALL_PATH" --transition-type outer --transition-step 90 --transition-fps 120
matugen image "$WALL_PATH" -m dark -s scheme-vibrant

# 3. GTK Sync (The "Bell Ringer")
if command -v xsettingsd >/dev/null; then
    THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")
    echo "Net/ThemeName \"Adwaita\"" | timeout 0.1 xsettingsd
    echo "Net/ThemeName \"$THEME\"" | timeout 0.1 xsettingsd
fi

# 4. App Reloads
cat ~/.cache/matugen/ironbar.css ~/.config/ironbar/base.css > ~/.config/ironbar/style.css
ironbar reload
hyprctl reload

# 5. SwayNC Fix (Reset then Reload)
swaync-client -R
swaync-client -rs

# 6. Third Party
spicetify apply
walker --gapplication-service --replace & disown

# 7. Zen Browser
pkill zen && zen & disown

notify-send -a "System" "Theme Synced" "$(basename "$WALL_PATH")"