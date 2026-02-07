if status is-interactive
    # This disables the default "Welcome to fish" text
    set -g fish_greeting 

    # Runs your fastfetch with the clean logo we set up
    fastfetch
end


function ocean
    set -l wall_path $argv[1]
    
    # Fallback to your main wallpaper if no argument is passed
    if test -z "$wall_path"
        set wall_path ~/Walls/wallpaper1.jpg
    end

    # Run Matugen to generate the new colors from the image
    matugen image "$wall_path"

    # Refresh all the UI components
    hyprctl reload
    killall waybar; and waybar & disown
    swaync-client -rs
    pkill walker

    echo (set_color -o blue)"Theme Refreshed!"
    echo (set_color cyan)"Applied colors from: "(basename "$wall_path")
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