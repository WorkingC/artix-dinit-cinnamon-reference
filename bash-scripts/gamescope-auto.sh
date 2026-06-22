#!/bin/sh
  while true; do
		gamescope -w 1920 -h 1080 -W 1920 -H 1080 -r 60 -f --force-grab-cursor --display-index=0
		echo "gamescope exited, restarting in 1 second..." >&2
		sleep 1
	done

# The unexpected >&22 at the end of line 4 just tells the system not to send the echo to stdout. 
# This is a looping script, so alt+f4 or unexpected crash would send that to the log. 
# The echo is for the purposes of watching it in a terminal. 
