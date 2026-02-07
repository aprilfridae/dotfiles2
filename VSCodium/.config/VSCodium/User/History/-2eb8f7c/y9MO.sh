#!/bin/bash

# Ensure socat is installed
if ! command -v socat &> /dev/null; then
    echo "socat not found. Please install it (yay -S socat)."
    exit 1
fi

# Listen to Hyprland events
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    # When focus changes...
    if [[ $line == "activewindow>>"* ]]; then
        # Check if the new focused window is NOT our TUI apps
        # We check the window title or class depending on what your terminal sends
        if [[ ! $line =~ "AudioMixer" ]] && [[ ! $line =~ "SystemTray" ]]; then
            pkill -f "ncpamixer"
            pkill -f "tray-tui"
        fi
    fi
done