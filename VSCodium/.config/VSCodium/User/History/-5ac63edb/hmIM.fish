if status is-interactive
    # This disables the default "Welcome to fish" text
    set -g fish_greeting 

    # Runs your fastfetch with the clean logo we set up
    fastfetch
end


function ocean
    # 1. Get last wallpaper path
    set -l wall_path (cat ~/.cache/.current_wallpaper 2>/dev/null; or echo ~/Walls/wallpaper1.jpg)

    # 2. Run Matugen
    matugen image "$wall_path"

    sleep 0.2

    # 3. Nuclear UI Reset (Clean separate lines)
    hyprctl reload

    killall waybar

    sleep 0.1

    
    waybar & disown
    
    swaync-client -rs
    
    pkill walker

    # 4. Success Notification
    # This will use your new Matugen accent colors automatically
    swaync-client -t -nm "theme set" "matugen colors synced with "(basename "$wall_path")
end

function set-wall
    if test -n "$argv[1]"
        set -l wall_path (realpath "$argv[1]")
        
        # Set the wallpaper
        awww img "$wall_path"
        
        # Bookmark it for the ocean command
        echo "$wall_path" > ~/.cache/.current_wallpaper
        
        # Trigger the refresh engine
        ocean
    else
        swaync-client -t -nm "Wallpaper Error" "No path provided."
    end
end