#!/usr/bin/env fish

# 1. Absolute path to your wallpapers
set wall_dir (realpath ~/Walls)

# 2. Get the list and pipe to Walker
# We quote the regex to stop Fish from complaining about the $
set selected (ls $wall_dir | grep -E '\.(jpg|jpeg|png|webp)$' | walker --dmenu)

# 3. Check if a selection was made
if test -n "$selected"
    # Ensure your set-wall function is available
    set-wall "$wall_dir/$selected"
else
    # Optional: notify if canceled
    notify-send -a "System" "Wallpaper" "No selection made."
end