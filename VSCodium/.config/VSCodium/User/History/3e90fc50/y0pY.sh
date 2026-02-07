#!/bin/bash

# 1. Handle Arguments & Cache
for arg in "$@"; do
    if [[ ! "$arg" == -* ]]; then
        WALL_PATH=$(realpath "$arg")
        echo "$WALL_PATH" > "$HOME/.cache/.current_wallpaper"
        break
    fi
done

if [ -z "$WALL_PATH" ]; then
    WALL_PATH=$(cat "$HOME/.cache/.current_wallpaper" 2>/dev/null || echo "$HOME/Pictures/wallpapers/default.jpg")
fi

# 2. Wallpaper & Colors
awww img "$WALL_PATH" --transition-type outer --transition-step 90 --transition-fps 120
matugen image "$WALL_PATH" --mode dark --type scheme-vibrant

# --- NEW: VSCodium Safe Merge ---
CODIUM_SETTINGS="$HOME/.config/VSCodium/User/settings.json"
MATUGEN_JSON="$HOME/.config/VSCodium/User/matugen_colors.json"

if [ -f "$MATUGEN_JSON" ] && command -v jq >/dev/null; then
    # Merge Matugen colors/settings into main settings.json
    jq -s '.[0] * .[1]' "$CODIUM_SETTINGS" "$MATUGEN_JSON" > "$CODIUM_SETTINGS.tmp" && mv "$CODIUM_SETTINGS.tmp" "$CODIUM_SETTINGS"
    echo "✅ Codium settings merged"
fi
# --------------------------------

# 3. Kitty & GTK Jiggle
pkill -USR1 kitty

# 4. Thunar Refresh
WAS_OPEN=$(pgrep -x thunar)
thunar -q
pkill -9 thunar 2>/dev/null
sleep 0.5
thunar --daemon &

if [ -n "$WAS_OPEN" ]; then
    sleep 0.3
    thunar & 
fi

if command -v xsettingsd >/dev/null; then
    CURRENT_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
    echo "Net/ThemeName \"Adwaita\"" | timeout 0.1 xsettingsd
    sleep 0.2 
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
pkill -9 walker
sleep 0.2
walker --gapplication-service & disown
rm -rf ~/.cache/walker
walker --gapplication-service & disown

# 6. Zen Browser
ZEN_BIN=$(command -v zen-browser || command -v zen)
if [ -n "$ZEN_BIN" ]; then
    pkill -x "$(basename "$ZEN_BIN")"
    $ZEN_BIN & disown
fi

notify-send -a "System" "Theme Synced" "$(basename "$WALL_PATH")"