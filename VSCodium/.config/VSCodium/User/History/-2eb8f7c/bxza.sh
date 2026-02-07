#!/bin/bash

# Kill old instances of this script
pkill -f socat

# Listen for the focus change
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    if [[ $line == "activewindow>>"* ]]; then
        # If the new focused window is NOT our widgets
        if [[ ! "$line" =~ "AudioMixer" ]] && [[ ! "$line" =~ "SystemTray" ]]; then
            # Tell Hyprland to close them by title
            hyprctl dispatch closewindow title:^AudioMixer$
            hyprctl dispatch closewindow title:^SystemTray$
        fi
    fi
done