#!/bin/bash
# 1. Get your current theme name from gsettings
THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")

# 2. Use xsettingsd to broadcast the change
# We toggle to a dummy theme and back instantly to force a "repaint"
echo "Net/ThemeName \"Adwaita\"" | timeout 0.1 xsettingsd
echo "Net/ThemeName \"$THEME\"" | timeout 0.1 xsettingsd