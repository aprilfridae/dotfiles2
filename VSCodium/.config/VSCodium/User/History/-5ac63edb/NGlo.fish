if status is-interactive
    set -g fish_greeting 
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

    # 4. Run Matugen
    # This generates colors for ironbar, walker, etc.
    matugen image "$wall_path" --mode dark --type scheme-neutral

    set -l config_dir "$HOME/.config/ironbar"
    set -l wall_path (cat ~/.cache/.current_wallpaper 2>/dev/null; or echo ~/Pictures/wallpapers/ocean_wallpaper.jpg)

    # 3. Direct Injection (The Hot Reload Trick)
    # We combine them into style.css (the file Ironbar is watching)
    if test -f "$config_dir/colors.css"; and test -f "$config_dir/base.css"
        cat "$config_dir/colors.css" "$config_dir/base.css" > "$config_dir/style.css"
        
        # 4. Trigger Ironbar to re-read the now-changed style.css
        ironbar reload
    else
        notify-send "Ironbar Error" "Base or Colors CSS missing in $config_dir"

    # ... rest of your refresh logic (swaync, walker, etc.)

    # 5. The UI Refresh
    sleep 0.3
    hyprctl reload
    
    # Refresh Notifications
    swaync-client -rs
    
    # REFRESH WALKER
    pkill walker
    walker --gapplication-service & disown 

    # 6. Success Notification
    notify-send -a "System" "Theme Set" "Synced with: "(basename "$wall_path")" (.$ext)"
end

function set-wall
    if test -n "$argv[1]"
        set -l wall_path (realpath "$argv[1]")
        # Using 'awww' as requested
        awww img "$wall_path"
        echo "$wall_path" > ~/.cache/.current_wallpaper
        ocean
    else
        notify-send -a "System" "Wallpaper Error" "No path provided."
    end
end