#!/usr/bin/env fish

set wall_dir ~/Pictures/wallpapers

echo "["
set files (ls $wall_dir)
for i in (seq (count $files))
    set file $files[$i]
    set full_path "$wall_dir/$file"
    
    # Create a JSON object for each image
    echo "  {"
    echo "    \"label\": \"$file\","
    echo "    \"sub\": \"$wall_dir\","
    echo "    \"icon\": \"$full_path\"," 
    echo "    \"exec\": \"fish -c 'set-wall $full_path'\""
    
    if test $i -eq (count $files)
        echo "  }"
    else
        echo "  },"
    end
end
echo "]"