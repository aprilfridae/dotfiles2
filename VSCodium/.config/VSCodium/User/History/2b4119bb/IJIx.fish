function ocean

    set -l wall_path (cat ~/.cache/.current_wallpaper 2>/dev/null; or echo ~/Pictures/wallpapers/ocean_wallpaper.jpg)

    set -l ext (string split -r -m1 . "$wall_path")[2]

    rm -f ~/.cache/link_wallpaper.png

    ln -sf "$wall_path" ~/.cache/link_wallpaper.png

    matugen image "$wall_path" --mode dark --type scheme-fruit-salad --contrast -0.5

    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
    
    sleep 0.1

    gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"

    cat ~/.config/ironbar/colors.css ~/.config/ironbar/base.css > ~/.config/ironbar/style.css

    ironbar reload

    sleep 0.3

    swaync-client -rs

    hyprctl reload
    
    pkill -9 walker

    sleep 0.5

    walker --gapplication-service & disown 
    
    notify-send -a "System" "Theme Set" "Synced with: "(basename "$wall_path")" (.$ext)"
end