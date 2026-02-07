Fridae-Dotfiles

A Hyprland configuration centered around dynamic color generation and the split-monitor-workspaces plugin.
Core Components

    Window Manager: Hyprland

    Bar: Ironbar / nwg-panel

    Shell: Fish

    Notifications: SwayNC

Dependencies

    Matugen

    Zen

    Walker

    Spicetify

    Kitty

    JQ

    Codium

    nwg-look

    Fish

    Ironbar

    Fastfetch

    Millennium

    Vesktop

    Cava

    Btop

    GNU Stow

    hyprland-plugins (split-monitor-workspaces)

Keybinds

    Super + B: Browser (Zen)

    Super + Space: Walker Launcher

    Super + L: Lock Screen

    Super + D: Vesktop

    Super + N: SwayNC Notifications

    Super + W: Wallpaper Picker

    Super + Q: Terminal (Kitty)

    Super + E: File Manager

    Super + C: Kill Active Window

    Super + M: Exit Hyprland

    Super + V: Toggle Floating

    Super + 1-5: Switch Workspaces (Split-Monitor)

    Super + Shift + 1-5: Move Window to Workspace

Installation

    Clone the repository: git clone https://github.com/aprilfridae/dotfiles2.git ~/dotfiles2

    Navigate to the directory: cd ~/dotfiles2

    Symlink the configurations using GNU Stow: stow hypr kitty matugen vscodium walker btop cava fastfetch fish swaync ironbar nwg-panel spicetify vesktop nwg-look millennium

    Plugins: Install and enable the split-monitor-workspaces plugin via hyprpm or your preferred method.

The Ocean Script

The ocean.sh script automates theme switching. It uses Matugen to generate colors from a wallpaper and uses JQ to inject those colors into Codium's settings.

Usage: ./scripts/ocean.sh /path/to/wallpaper.png
