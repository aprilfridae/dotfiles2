#!/usr/bin/env fish

# Expand tilde to absolute path for reliability
set wall_dir (realpath ~/Walls)

echo "["
# Filter for common image extensions
set files (ls $wall_dir | grep -E "\.(jpg|jpeg|png|webp|gif|bmp)$")
set total_files (count $files)

for i in (seq $total_files)
    set file $files[$i]
    set full_path "$wall_dir/$file"
    
    echo "  {"
    echo "    \"label\": \"$file\","
    echo "    \"sub\": \"$wall_dir\","
    echo "    \"icon\": \"$full_path\"," 
    echo "    \"exec\": \"fish -c 'set-wall \\\"$full_path\\\"'\""
    
    if test $i -eq $total_files
        echo "  }"
    else
        echo "  },"
    end
end
echo "]"