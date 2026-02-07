if status is-interactive
    # This disables the default "Welcome to fish" text
    set -g fish_greeting 

    # Runs your fastfetch with the clean logo we set up
    fastfetch
end


function ocean
    # 1. Get the last used wallpaper path
    set -l wall_path (cat ~/.cache/.current_wallpaper 2>/dev/null; or echo ~/Pictures/wallpapers/ocean_wallpaper.jpg)

    # 2. Get the file extension
    set -l ext (string split -r -m1 . "$wall_path")[2]

    # 3. Manage the Hyprlock Symlink
    rm -f ~/.cache/link_wallpaper.png
    ln -sf "$wall_path" ~/.cache/link_wallpaper.png

    # 4. Matugen Run
    matugen image "$wall_path" --mode dark

    # 5. The Nuclear UI Refresh
    sleep 0.3
    hyprctl reload
    
    # Refresh Waybar
    killall -9 waybar
    sleep 0.2
    waybar & disown
    
    # Refresh Notifications
    swaync-client -rs
    
    # REFRESH WALKER
    pkill walker
    walker --gapplication-service & disown # Restarts Walker in service mode

    # 6. Success Notification
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


function fixicons
    # 1. Create a safe temporary spot for the 'clean' files
    mkdir -p ~/April-Fridae-Final

    # 2. Use rsync with -L (copy-links) to turn links into real files
    # Note: The trailing slash on the source path is important!
    rsync -aL ~/.local/share/icons/aprilicons/ ~/April-Fridae-Final/

    # 3. Wipe the old 'broken' folder and replace it with the clean one
    rm -rf ~/.local/share/icons/aprilicons/
    mv ~/April-Fridae-Final ~/.local/share/icons/aprilicons

    # 4. Tell the system to refresh its icon list
    gtk-update-icon-cache -f ~/.local/share/icons/aprilicons

    echo "✅ Icons fixed and dereferenced! Ready for nwg-look."
end
