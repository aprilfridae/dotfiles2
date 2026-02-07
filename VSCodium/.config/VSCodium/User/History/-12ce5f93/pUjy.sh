#!/bin/bash

# Define paths
CACHE_FILE="$HOME/.cache/matugen/zen.css"
ZEN_DIR="$HOME/.zen"

# 1. Find the Zen profile (matches anything with 'default' or 'Default')
# This handles the weird "c2uso7pn.Default (release)" naming automatically
PROFILE_PATH=$(find "$ZEN_DIR" -maxdepth 1 -type d -name "*efault*" | head -n 1)

if [ -z "$PROFILE_PATH" ]; then
    echo "❌ Error: Could not find a Zen profile in $ZEN_DIR"
    exit 1
fi

CHROME_DIR="$PROFILE_PATH/chrome"
echo "✅ Found Zen profile: $(basename "$PROFILE_PATH")"

# 2. Create the chrome directory if it doesn't exist
mkdir -p "$CHROME_DIR"

# 3. Create the symlink to your Matugen cache
# This keeps the dotfiles clean while pointing to the 'live' colors
ln -sf "$CACHE_FILE" "$CHROME_DIR/colors.css"
echo "✅ Created symlink: colors.css -> $CACHE_FILE"

# 4. Create the userChrome.css if it doesn't exist, or ensure imports are there
USER_CHROME="$CHROME_DIR/userChrome.css"

if [ ! -f "$USER_CHROME" ]; then
    echo "Creating new userChrome.css..."
    cat <<EOF > "$USER_CHROME"
/* 1. Your Zen Mods (Glass, Animations, etc.) */
@import url("zen-themes.css");

/* 2. Your Matugen-generated PywalZen-style colors */
@import url("colors.css");
EOF
else
    # If file exists, check if @import "colors.css" is already there
    if ! grep -q 'import url("colors.css")' "$USER_CHROME"; then
        echo "Appending Matugen import to existing userChrome.css..."
        echo '@import url("colors.css");' >> "$USER_CHROME"
    fi
fi

echo "🚀 Zen is now linked to Matugen!"
echo "⚠️  Final Step: Open Zen, go to about:config, and set"
echo "   'toolkit.legacyUserProfileCustomizations.stylesheets' to true"