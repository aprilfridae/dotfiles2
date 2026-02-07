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
    matugen image "$wall_path" --mode dark --type scheme-neutral
    
    # 1. Get the Matugen Primary color (stripped hex)
    set -l accent_hex (matugen color hex primary)
    
    # 2. Convert Hex to GLSL RGB (0.0 to 1.0)
    # This is a bit of math to make the shader understand the color
    set -l r (math -s3 (printf "0x%s" (string sub -s 1 -l 2 $accent_hex)) / 255)
    set -l g (math -s3 (printf "0x%s" (string sub -s 3 -l 2 $accent_hex)) / 255)
    set -l b (math -s3 (printf "0x%s" (string sub -s 5 -l 2 $accent_hex)) / 255)

    # 3. Create the active shader by replacing the placeholders
    sed "s/R_VAL/$r/g; s/G_VAL/$g/g; s/B_VAL/$b/g" ~/.config/hypr/shaders/tint.frag > ~/.config/hypr/shaders/current_tint.glsl

    # 4. Tell Hyprland to apply the tint to all windows (except waybar/wallpaper)
    hyprctl keyword decoration:screen_shader ~/.config/hypr/shaders/current_tint.glsl

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
