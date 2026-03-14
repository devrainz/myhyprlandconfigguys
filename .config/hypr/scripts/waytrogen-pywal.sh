#!/usr/bin/env bash
# Waytrogen passes:
# $1 = monitor (ignore)
# $2 = wallpaper path
# $3 = json state (ignore)

WALLPAPER="$2"
HYPRLOCK_DIR="$HOME/.config/hypr"
HYPRLOCK_BG="$HYPRLOCK_DIR/background.jpg"

# Ensure hypr directory exists
mkdir -p "$HYPRLOCK_DIR"

# Attempt to copy wallpaper safely
if [ -f "$WALLPAPER" ]; then
    # Delete previous backgrounds of any type
    rm -f "$HYPRLOCK_DIR"/background.* 2>/dev/null
    
    # Copy the wallpaper as background.jpg (convert if needed)
    cp "$WALLPAPER" "$HYPRLOCK_BG" || echo "Warning: failed to copy wallpaper, continuing..."
else
    echo "Warning: wallpaper file does not exist, skipping copy"
fi

# Apply Pywal on the original wallpaper (this always runs)
wal -i "$WALLPAPER" -q

# Reload Waybar + Mako for Pywal colors
pkill waybar; waybar &
pkill mako; mako &

exit 0
