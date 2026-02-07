#!/bin/bash
# Kill any existing listeners
pkill -f "socat -U - UNIX-CONNECT"

# Use the reliable socket path
SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

socat -U - UNIX-CONNECT:"$SOCKET" | while read -r line; do
    # Only trigger when focus actually shifts to a NEW window
    if [[ $line == "activewindow>>"* ]]; then
        # If the window gaining focus is NOT the mixer or tray...
        if [[ ! "$line" =~ "AudioMixer" ]] && [[ ! "$line" =~ "SystemTray" ]]; then
            
            # Check if AudioMixer is currently open before trying to kill it
            if hyprctl clients | grep -q "title: AudioMixer"; then
                hyprctl dispatch closewindow title:^AudioMixer$
            fi
            
            # Check if SystemTray is currently open
            if hyprctl clients | grep -q "title: SystemTray"; then
                hyprctl dispatch closewindow title:^SystemTray$
            fi
        fi
    fi
done