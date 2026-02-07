# Force Fish to stay blue/grey (No more purple)
set -g fish_color_normal {{colors.on_surface.default.hex_stripped}}
set -g fish_color_command {{colors.primary.default.hex_stripped}}
set -g fish_color_quote {{colors.secondary.default.hex_stripped}}
set -g fish_color_redirection {{colors.primary.default.hex_stripped}} # Changed from tertiary
set -g fish_color_end {{colors.secondary.default.hex_stripped}}       # Changed from tertiary
set -g fish_color_error {{colors.error.default.hex_stripped}}
set -g fish_color_param {{colors.on_surface_variant.default.hex_stripped}}
set -g fish_color_autosuggestion {{colors.outline.default.hex_stripped}}