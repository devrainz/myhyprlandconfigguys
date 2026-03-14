#!/bin/bash

PIDFILE="/tmp/autoclick.pid"
INTERVAL=0.05   # seconds (20 CPS)
BTN_CODE=272    # 272 = left click

SOUND_ON="/home/rainz/switch_006.ogg"
SOUND_OFF="/home/rainz/switch_005.ogg"

start_clicker() {
  notify-send "Autoclicker" "Started"
  play "$SOUND_ON" >/dev/null 2>&1 &

  (
    while true; do
      ydotool key $BTN_CODE:1 $BTN_CODE:0
      sleep $INTERVAL
    done
  ) &

  echo $! > "$PIDFILE"
}

stop_clicker() {
  if [[ -f "$PIDFILE" ]]; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    rm -f "$PIDFILE"
  fi

  notify-send "Autoclicker" "Stopped"
  play "$SOUND_OFF" >/dev/null 2>&1 &
}

if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
  stop_clicker
else
  start_clicker
fi
