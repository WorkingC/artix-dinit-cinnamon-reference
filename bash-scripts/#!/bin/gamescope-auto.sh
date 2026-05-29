#!/bin/sh
  while true; do
		gamescope -w 1920 -h 1080 -W 1920 -H 1080 -r 60 -f --force-grab-cursor --display-index=0
		echo "gamescope exited, restarting in 1 second..." >&2
		sleep 1
	done
