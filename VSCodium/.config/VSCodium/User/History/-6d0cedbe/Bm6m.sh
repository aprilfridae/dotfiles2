#!/usr/bin/env fish

# 1. Path to your wallpapers
set wall_dir (realpath ~/Walls)

# 2. Get list of files and pipe to Walker dmenu
# --dmenu: tells Walker to act as a selector
# --terminal: false ensures it doesn't try to open a terminal
set selected (ls $wall_dir | grep -E "\.(jpg|jpeg|png|webp)$" | walker --dmenu)

# 3. If you didn't hit Escape, run your set-wall function
if test -n "$selected"
    set-wall "$wall_dir/$selected"
end