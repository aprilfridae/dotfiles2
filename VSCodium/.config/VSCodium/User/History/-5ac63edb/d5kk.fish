if status is-interactive
    # This disables the default "Welcome to fish" text
    set -g fish_greeting 

    # Runs your fastfetch with the clean logo we set up
    fastfetch
end


function ocean
    # 1. Get the last used wallpaper path
    set -l wall_path (cat ~/.cache/.current_wallpaper 2>/dev/null; or echo ~/Pictures/wallpapers/ocean_wallpaper.jpg)

    # 2. Get the file extension (detects .jpg, .png, .webp, etc.)
    set -l ext (string split -r -m1 . "$wall_path")[2]

    # 3. Manage the Hyprlock Symlink
    # We use .png as the standard link name for the config, but it points to the real file
    rm -f ~/.cache/link_wallpaper.png
    ln -sf "$wall_path" ~/.cache/link_wallpaper.png

    # 4. Generate colors with Matugen (using neutral for the Obsidian vibe)
    matugen -m dark -s scheme-neutral image "$wall_path"

    # 5. The Nuclear UI Refresh (Clean separate lines)
    sleep 0.3
    hyprctl reload
    
    killall -9 waybar
    sleep 0.2
    waybar & disown
    
    swaync-client -rs
    pkill walker

    # 6. Success Notification
    # Uses -a for the app name and includes the file extension in the message
    notify-send -a "System" "Theme Set" "Synced with: "(basename "$wall_path")" (.$ext)"
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