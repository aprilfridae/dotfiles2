#!/bin/bash

# Kill any existing listeners
pkill -f socat

# Listen to the Hyprland event socket
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    # Trigger on active window change
    if [[ $line == "activewindow>>"* ]]; then
        # Check if the event contains our dashboard titles
        # If it DOES NOT contain AudioMixer AND DOES NOT contain SystemTray, kill them
        if [[ ! "$line" =~ "AudioMixer" ]] && [[ ! "$line" =~ "SystemTray" ]]; then
            pkill -f "ncpamixer"
            pkill -f "tray-tui"
        fi
    fi
done