#!/usr/bin/env fish

# 1. Define your wallpaper directory
set wall_dir (realpath ~/Walls)

# 2. Get the file list and pipe it to walker
# We use --dmenu and pipe the output to a variable
set selected (ls $wall_dir | grep -E "\.(jpg|jpeg|png|webp)$" | walker --dmenu)

# 3. Check if we actually got a selection (avoids errors on Escape)
if test -n "$selected"
    # We call the function explicitly by sourcing the config if needed
    # or just calling it directly if it's already in your path
    set-wall "$wall_dir/$selected"
end