#!/usr/bin/env fish

# 1. Path to wallpapers
set wall_dir (realpath ~/Walls)

# 2. Build the JSON array
echo "["
set files (ls $wall_dir | grep -E '\.(jpg|jpeg|png|webp)$')
set total (count $files)

for i in (seq $total)
    set file $files[$i]
    set full_path "$wall_dir/$file"
    
    # Create JSON object for Walker
    # 'label' is the text shown, 'icon' is the thumbnail path
    echo "  {"
    echo "    \"label\": \"$file\","
    echo "    \"icon\": \"$full_path\""
    
    if test $i -eq $total
        echo "  }"
    else
        echo "  },"
    end
end
echo "]" | walker --dmenu | read -l selected

# 3. Handle the selection
if test -n "$selected"
    # Walker dmenu returns the 'label' value by default
    set-wall "$wall_dir/$selected"
end