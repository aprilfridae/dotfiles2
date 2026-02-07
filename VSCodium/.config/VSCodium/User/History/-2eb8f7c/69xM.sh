#!/bin/bash

# Ensure any old listeners are dead
pkill -f socat

# Start listening to Hyprland events
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    # Listen for ANY change in active window
    if [[ $line == "activewindow>>"* ]]; then
        # If the new window is NOT our mixer or tray
        if [[ ! "$line" =~ "AudioMixer" ]] && [[ ! "$line" =~ "SystemTray" ]]; then
            # Close the windows by their title using Hyprland's dispatch
            hyprctl dispatch closewindow title:^AudioMixer$
            hyprctl dispatch closewindow title:^SystemTray$
        fi
    fi
done