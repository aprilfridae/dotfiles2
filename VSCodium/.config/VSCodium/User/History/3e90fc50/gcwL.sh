#!/bin/bash

# 1. Path Logic
# If an argument is passed, use it and save it. Otherwise, use the saved one.
if [ -n "$1" ]; then
    WALL_PATH=$(realpath "$1")
    echo "$WALL_PATH" > ~/.cache/.current_wallpaper
else
    WALL_PATH=$(cat ~/.cache/.current_wallpaper 2>/dev/null || echo "$HOME/Pictures/wallpapers/default.jpg")
fi

# 2. Set Wallpaper (Awww transition)
awww img "$WALL_PATH" --transition-type outer --transition-step 90 --transition-fps 120

# 3. Generate Colors
matugen image "$WALL_PATH" -m dark -s scheme-vibrant

# 4. Sync GTK (The xsettingsd Bell Ringer)
if command -v xsettingsd >/dev/null; then
    THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")
    echo "Net/ThemeName \"Adwaita\"" | timeout 0.1 xsettingsd
    echo "Net/ThemeName \"$THEME\"" | timeout 0.1 xsettingsd
fi

# 5. UI Core Reloads
cat ~/.cache/matugen/ironbar.css ~/.config/ironbar/base.css > ~/.config/ironbar/style.css
ironbar reload
hyprctl reload
swaync-client -R
swaync-client -rs
spicetify apply
walker --gapplication-service --replace & disown

# 6. Zen Browser (Restarting to apply)
pkill zen && zen & disown

notify-send -a "System" "Theme Synced" "$(basename "$WALL_PATH")"