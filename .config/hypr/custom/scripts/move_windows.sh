#!/usr/bin/env bash

# Launch the windows
kitty --title KITTY_MAIN &
kitty --title KITTY_CLOCK clock-rs &

# Wait for both windows
while true; do
    WIN1=$(hyprctl clients -j | jq -r '.[] | select(.title=="KITTY_MAIN") | .address')
    WIN2=$(hyprctl clients -j | jq -r '.[] | select(.title=="KITTY_CLOCK") | .address')

    if [[ -n "$WIN1" && -n "$WIN2" ]]; then
        break
    fi
    sleep 0.1
done

# Move to workspace 1
hyprctl dispatch movetoworkspace 1,address:$WIN1
hyprctl dispatch movetoworkspace 1,address:$WIN2

# MAKE THEM FLOATING (REQUIRED)
hyprctl dispatch togglefloating address:$WIN1
hyprctl dispatch togglefloating address:$WIN2

# Resize & position
hyprctl dispatch resizewindowpixel exact 910 576,address:$WIN1
hyprctl dispatch movewindowpixel exact 39 98,address:$WIN1

hyprctl dispatch resizewindowpixel exact 680 342,address:$WIN2
hyprctl dispatch movewindowpixel exact 1204 693,address:$WIN2

# Focus workspace
hyprctl dispatch workspace 1

echo "ok"
