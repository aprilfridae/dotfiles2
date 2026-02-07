#!/bin/bash
# Listen for workspace or focus changes
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    if [[ $line == activewindowv2* ]]; then
        # If the new active window is NOT our mixer or tray, kill them
        if [[ ! $line =~ "AudioMixer" ]] && [[ ! $line =~ "SystemTray" ]]; then
            pkill -f "ncpamixer"
            pkill -f "tray-tui"
        fi
    fi
done