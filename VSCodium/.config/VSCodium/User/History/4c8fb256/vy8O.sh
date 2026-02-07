#!/usr/bin/env fish

# 1. Define where your walls are
set wall_dir (realpath ~/Walls)

# 2. Get list of files and pipe them to walker dmenu
# This is simple text-in, text-out.
set selected (ls $wall_dir | grep -E '\.(jpg|jpeg|png|webp)$' | walker --dmenu)

# 3. If you didn't hit Escape, run your set-wall function
if test -n "$selected"
    source ~/.config/fish/config.fish
    set-wall "$wall_dir/$selected"
end