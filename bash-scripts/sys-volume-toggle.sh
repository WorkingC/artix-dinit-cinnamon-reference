#!/bin/bash
STATE_FILE="/tmp/system_volume_state"
if [ -f "$STATE_FILE" ]; then
    LAST=$(cat "$STATE_FILE")
else
    LAST=1
fi

if [ "$LAST" -eq 1 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ 33%
    echo 0 > "$STATE_FILE"
else
    pactl set-sink-volume @DEFAULT_SINK@ 100%
    echo 1 > "$STATE_FILE"
fi