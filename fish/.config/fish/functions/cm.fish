function cm --wraps='cd ~/Color-manager && source venv/bin/activate.fish && python color_manager/gui.py' --description 'alias cm=cd ~/Color-manager && source venv/bin/activate.fish && python color_manager/gui.py'
    cd ~/Color-manager && source venv/bin/activate.fish && python color_manager/gui.py $argv
end
