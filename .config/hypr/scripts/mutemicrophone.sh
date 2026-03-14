#!/bin/bash

MUTE_SOUND="/home/rainz/turnoffmic.mp3"
UNMUTE_SOUND="/home/rainz/turnonmic.mp3"

SOURCE="alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Mic1__source"

STATE=$(pactl get-source-mute "$SOURCE" | awk '{print $2}')

if [ "$STATE" = "yes" ]; then
    pactl set-source-mute "$SOURCE" 0
    notify-send "Mic" "🎙️ Microphone Unmuted" -t 2000
    paplay "$UNMUTE_SOUND" &
else
    pactl set-source-mute "$SOURCE" 1
    notify-send "Mic" "🔇 Microphone Muted" -t 2000
    paplay "$MUTE_SOUND" &
fi

# 🔥 THIS LINE TELLS SWAYOSD TO UPDATE ITS DISPLAY
swayosd-client --input-volume mute-toggle
