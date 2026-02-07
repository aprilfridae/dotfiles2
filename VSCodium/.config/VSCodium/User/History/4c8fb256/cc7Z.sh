#!/usr/bin/env fish

set wall_dir (realpath ~/Walls)
set files (ls $wall_dir | grep -E '\.(jpg|jpeg|png|webp)$')
set total (count $files)

echo "["
for i in (seq $total)
    set file $files[$i]
    set full_path "$wall_dir/$file"
    
    echo "  {"
    echo "    \"label\": \"$file\","
    echo "    \"icon\": \"$full_path\","
    echo "    \"exec\": \"fish -c 'set-wall $full_path'\""
    
    if test $i -eq $total
        echo "  }"
    else
        echo "  },"
    end
end
echo "]"