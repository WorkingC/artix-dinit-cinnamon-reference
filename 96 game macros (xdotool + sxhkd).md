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
## Coming from AHK
### Sleep
Sleep in AHK is 1/1000th of a second. Sleep in bash is 1 whole second. 
```
sleep 100   > sleep 0.100    # 1/10th of a second
sleep 24    > sleep 0.024    # 24/1000ths of a second
```
### Send > Key and Type
Each Key must have a space. 
```
send "123"    > xdotool key 1 2 3
```
For longer strings, use xdotool type:
```
# AHK
Send "Billy Bob Joe."
# xdotool
xdotool type "Billy Bob Joe."
```
### SetKeyDelay > Sleep
In AHK, SetKeyDelay X, Y sets the delay between the down and up part of the keystroke with X, and the delay between two strokes with Y. xdotool does not have a SetKeyDelay variable. Instead, you'll have to do something like this for each key.
```
# AHK
SetKeyDelay 16, 8
Send "12"

# xdotool
xdotool keydown 1 && sleep 0.016 && xdotool keyup 1 && sleep 0.008
xdotool keydown 2 && sleep 0.016 && xdotool keyup 2 && sleep 0.008
```
