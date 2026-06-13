#!/bin/bash
STATE_FILE="/tmp/foobar_volume_state"
ID=$(pactl list sink-inputs | grep -B 20 "foobar2000 Application" | grep -Po "Sink Input #\K\d+" | head -1)

if [ -z "$ID" ]; then
    exit 0
fi

# Read last state (0 = was 66%, 1 = was 100%)
if [ -f "$STATE_FILE" ]; then
    LAST=$(cat "$STATE_FILE")
else
    LAST=1   # start by setting to 66%? Actually we'll default to 100% first time.
fi

if [ "$LAST" -eq 1 ]; then
    # Last was 100% → set to 66%
    pactl set-sink-input-volume "$ID" 66%
    echo 0 > "$STATE_FILE"
else
    # Last was 66% → set to 100%
    pactl set-sink-input-volume "$ID" 100%
    echo 1 > "$STATE_FILE"
fi