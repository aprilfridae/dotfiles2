# aprilfridae // dotfiles2

A dynamic Hyprland setup driven by **Matugen** colors and the **split-monitor-workspaces** plugin.

<img width="1920" height="1080" alt="2026-02-05-184044_hyprshot" src="https://github.com/user-attachments/assets/b8d77e48-5023-4e8f-9071-affc4f0a70ae" />
<img width="1920" height="1080" alt="2026-02-03-224814_hyprshot" src="https://github.com/user-attachments/assets/14b667a7-bc44-4b32-8e55-ad0c4bb3c3c4" />
<img width="3840" height="2160" alt="2026-02-03-224739_hyprshot" src="https://github.com/user-attachments/assets/dacb8b54-6955-4e2c-b822-ed61b6febcc9" />

---

## Core Components
* **WM:** Hyprland
* **Bar:** Ironbar / nwg-panel
* **Shell:** Fish
* **Notifications:** SwayNC

---

## Dependencies
* **Matugen** | **Zen** | **Walker** | **Spicetify** | **Kitty**
* **JQ** | **Codium** | **nwg-look** | **Fish** | **Ironbar**
* **Fastfetch** | **Millennium** | **Vesktop** | **Cava** | **Btop**
* **GNU Stow** | **hyprland-plugins** (split-monitor-workspaces)

---

## Keybinds

### Applications
| Keybind | Action |
| :--- | :--- |
| **Super + B** | Browser (Zen) |
| **Super + Space** | Walker Launcher |
| **Super + Q** | Terminal (Kitty) |
| **Super + E** | File Manager |
| **Super + D** | Vesktop |
| **Super + N** | Notifications (SwayNC) |
| **Super + L** | Screen Lock |
| **Super + W** | Wallpaper Picker |

### Window Management
| Keybind | Action |
| :--- | :--- |
| **Super + C** | Kill Window |
| **Super + V** | Toggle Float |
| **Super + M** | Exit Hyprland |
| **Super + 1-5** | Switch Workspaces (Split-Monitor) |
| **Super + Shift + 1-5** | Move Window to Workspace |

---

## Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/aprilfridae/dotfiles2.git](https://github.com/aprilfridae/dotfiles2.git) ~/dotfiles2

2. Navigate and link:
   ```bash

    cd ~/dotfiles2
    stow hypr kitty matugen vscodium walker btop cava fastfetch fish swaync ironbar nwg-panel spicetify vesktop nwg-look millennium

    Plugins: Install and enable the split-monitor-workspaces plugin via hyprpm.

The Ocean Script

The ocean.sh script handles the heavy lifting for the theme. It uses Matugen to pull a color palette from your wallpaper and JQ to live-inject those colors into Codium's settings.

Usage: Press Super + W to trigger the Walker menu and select a wallpaper from ~/Walls/.





