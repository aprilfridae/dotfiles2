#!/bin/bash

# 1. Handle Arguments & Cache
# This loop finds the first argument that isn't a flag (like -v)
for arg in "$@"; do
    if [[ ! "$arg" == -* ]]; then
        WALL_PATH=$(realpath "$arg")
        echo "$WALL_PATH" > "$HOME/.cache/.current_wallpaper"
        break
    fi
done

# Fallback to cache if no path was provided
if [ -z "$WALL_PATH" ]; then
    WALL_PATH=$(cat "$HOME/.cache/.current_wallpaper" 2>/dev/null || echo "$HOME/Pictures/wallpapers/default.jpg")
fi

# 2. Wallpaper & Colors
awww img "$WALL_PATH" --transition-type outer --transition-step 90 --transition-fps 120
# Your verified Matugen syntax
matugen image "$WALL_PATH" --mode dark --type scheme-vibrant

# 3. Kitty & GTK Jiggle
pkill -USR1 kitty

# 4. Thunar Refresh
thunar -q
pkill -9 thunar 2>/dev/null
sleep 1 # Give the DBus service a full second to clear the name

# Start the daemon
thunar --daemon &
sleep 0.5

if command -v xsettingsd >/dev/null; then
    CURRENT_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")
    
    # Force a hard switch via gsettings AND xsettingsd
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
    echo "Net/ThemeName \"Adwaita\"" | timeout 0.1 xsettingsd
    
    sleep 0.2 # Give GTK a moment to breathe
    
    gsettings set org.gnome.desktop.interface gtk-theme "$CURRENT_THEME"
    echo "Net/ThemeName \"$CURRENT_THEME\"" | timeout 0.1 xsettingsd
fi

# 4. App Reloads
cat "$HOME/.cache/matugen/ironbar.css" "$HOME/.config/ironbar/base.css" > "$HOME/.config/ironbar/style.css"
ironbar reload
hyprctl reload
swaync-client -R
swaync-client -rs

# 5. Spicetify & Walker
spicetify apply
pkill walker
walker --gapplication-service & disown

# 6. Zen Browser
# Checks for 'zen-browser' or 'zen' to avoid 'command not found'
ZEN_BIN=$(command -v zen-browser || command -v zen)
if [ -n "$ZEN_BIN" ]; then
    pkill -x "$(basename "$ZEN_BIN")"
    $ZEN_BIN & disown
fi

notify-send -a "System" "Theme Synced" "$(basename "$WALL_PATH")"