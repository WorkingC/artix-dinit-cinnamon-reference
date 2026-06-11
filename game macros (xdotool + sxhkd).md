# Game Macros 
If you come from an AutoHotKey background, you might expect that you'll have a single file of functions, hotkeys, and scripts. That's not the way it is here. Instead, you have a folder, an sxhkd config, 

## Prerequisites
```
sudo pacman -S xdotool sxhkd
```

## Sample script
```
#!/bin/sh

xdotool keydown g && sleep 0.024 && xdotool keyup g
sleep 0.036
xdotool keydown e && sleep 0.024 && xdotool keyup e
```

## Sample sxkhd config
```
# Fast Gestures (keyboard-only versions)
~1
    "/home/c/Documents/Game Macros/DSR Macros/fastGesture1.sh"

# HUD Toggle (key 8) – keyboard-only simulation of menu navigation
~8
    "/home/c/Documents/Game Macros/DSR Macros/HUD-toggle.sh"

# Quit Out (key 0)
~0
    "/home/c/Documents/Game Macros/DSR Macros/quit-out.sh"

# Reload sxhkd config on the fly (useful while developing)
control + alt + r
    pkill -USR1 sxhkd
```
