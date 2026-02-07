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
        set wall_path ~/Pictures/wallpapers/ocean_wallpaper.jpg
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
        # 1. Set the wallpaper using awww
        awww "$argv[1]"
        
        # 2. Pass that same path to your ocean function to update colors
        ocean "$argv[1]"
    else
        echo "Usage: set-wall ~/path/to/wallpaper.jpg"
    end
end