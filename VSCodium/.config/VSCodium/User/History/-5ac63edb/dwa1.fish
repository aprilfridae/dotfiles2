if status is-interactive
    # This disables the default "Welcome to fish" text
    set -g fish_greeting 

    # Runs your fastfetch with the clean logo we set up
    fastfetch
end


function ocean
    # 1. Get last wallpaper path
    set -l wall_path (cat ~/.cache/.current_wallpaper 2>/dev/null; or echo ~/Pictures/wallpapers/ocean_wallpaper.jpg)

    # 2. Update Symlink for Hyprlock
    ln -sf "$wall_path" ~/.cache/link_wallpaper.png

    # 3. Generate colors with Matugen
    matugen -m dark -s scheme-neutral image "$wall_path"

    # 4. Nuclear UI Reset
    sleep 0.3
    hyprctl reload
    
    killall -9 waybar
    sleep 0.2
    waybar & disown
    
    # Reload SwayNC daemon
    swaync-client -rs
    
    pkill walker

    # 5. Success Notification (Using notify-send)
    # -a sets the app name, -i can set an icon if you want
    notify-send -a "System" "Theme Set" "Ocean colors synced for April Fridae"
end

function set-wall
    if test -n "$argv[1]"
        set -l wall_path (realpath "$argv[1]")
        awww img "$wall_path"
        echo "$wall_path" > ~/.cache/.current_wallpaper
        ocean
    else
        notify-send -a "System" "Wallpaper Error" "No path provided."
    end
end