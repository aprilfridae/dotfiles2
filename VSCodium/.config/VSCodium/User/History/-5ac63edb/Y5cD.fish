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

    # Combine Matugen colors and your base layout into one file
    cat ~/.config/ironbar/colors.css ~/.config/ironbar/base.css > ~/.config/ironbar/style.css

    # Reload - Ironbar sees the file content has changed and updates instantly
    ironbar reload

    # 5. The UI Refresh
    sleep 0.3
    hyprctl reload
    
    # Refresh Notifications
    swaync-client -rs
    
# REFRESH WALKER
    pkill -9 walker
    sleep 0.5 # Give the socket time to clear
    
    # Start the service. 
    # Note: Use 'walker --service' if you are on the latest version
    walker --gapplication-service & disown 
    
    # Optional: Force walker to reload its config/theme
    walker --reload

    # 6. Success Notification
    notify-send -a "System" "Theme Set" "Synced with: "(basename "$wall_path")" (.$ext)"
end

function set-wall
    if test -n "$argv[1]"
        set -l wall_path (realpath "$argv[1]")
        # Using 'awww' as requested
        awww img "$wall_path" --transition-type outer --transition-pos top-right --transition-step 90 --transition-fps 120
        echo "$wall_path" > ~/.cache/.current_wallpaper
        ocean
    else
        notify-send -a "System" "Wallpaper Error" "No path provided."
    end
end