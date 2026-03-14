#!/bin/bash

DEVICE="/dev/input/event4"
TRIGGER="BTN_FORWARD"   # change if libinput shows something else
INTERVAL=0.05
BTN=272   # left click

CLICKPID=""

sudo libinput debug-events --device "$DEVICE" | while read -r line; do

    if [[ $line == *"$TRIGGER"*pressed* ]]; then
        
        if [[ -z "$CLICKPID" ]]; then
            (
                while true; do
                    ydotool key $BTN:1 $BTN:0
                    sleep $INTERVAL
                done
            ) &
            
            CLICKPID=$!
        fi
    fi


    if [[ $line == *"$TRIGGER"*released* ]]; then
        
        if [[ -n "$CLICKPID" ]]; then
            kill "$CLICKPID" 2>/dev/null
            CLICKPID=""
        fi
    fi

done
