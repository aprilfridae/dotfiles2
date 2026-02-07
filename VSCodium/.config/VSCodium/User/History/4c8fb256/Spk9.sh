#!/usr/bin/env fish

# 1. Path to wallpapers
set wall_dir (realpath ~/Walls)

# 2. Build the JSON array safely
set files (ls $wall_dir | grep -E '\.(jpg|jpeg|png|webp)$')
set total (count $files)

# Start JSON string
set json "["

for i in (seq $total)
    set file $files[$i]
    set full_path "$wall_dir/$file"
    
    # Append the item
    set json "$json{\"label\": \"$file\", \"icon\": \"$full_path\"}"
    
    # Add a comma if it's not the last item
    if test $i -lt $total
        set json "$json,"
    end
end

# Close JSON string
set json "$json]"

# 3. Pipe to Walker and capture selection
# Note: Some versions of Walker need the --dmenu flag to follow the input
echo $json | walker --dmenu | read -l selected

# 4. Handle the selection
if test -n "$selected"
    # source config just in case it's a new shell session
    source ~/.config/fish/config.fish
    set-wall "$wall_dir/$selected"
end