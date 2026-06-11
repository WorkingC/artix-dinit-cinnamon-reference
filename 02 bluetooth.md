# Bluetooth
There's not terribly much to installing and enabling Bluetooth. Just install the following packages and enable the service.
```
sudo pacman -S bluez bluez-utils bluez-dinit blueman
sudo dinitctl enable bluetoothd
```

## Connections
The Blueman application is a GUI bluetooth manager with clickable buttons and menus which are self explanatory. 

You can also connect to a device with the command line.
```
bluetoothctl
scan on
```	
Look for your controller to appear, then note the address. It'll be in XX:XX:XX:XX:XX:XX format. Then:
```	
rust XX:XX:XX:XX:XX:XX
pair XX:XX:XX:XX:XX:XX
connect XX:XX:XX:XX:XX:XX
```

## Tweaks
The Idle Timeout behavior might disrupt inputs on controller devices.
```
sudo nano /etc/bluetooth/input.conf
# Uncomment
IdleTimeout=0
```
Then:
```
sudo dinitctl restart bluetoothd
```
### On Nintendo Bluetooth devices
If you get an issue where you run through the trust-pair-connect sequence, then later reconnect your controller and then have no input, there's a  rough workaround. You need to put your controller in paring mode before the controller automatically connects, then manually connect to it. 

Yeah, that's cumbersome, but, you can automate that. 
```
#!/bin/sh
sleep 1
echo -e "connect XX:XX:XX:XX:XX:XX\nquit" | bluetoothctl
```
Save it, replace XX:XX:XX:XX:XX:XX with your device's MAC address, and attach it to a hotkey in Cinnamon's Keyboard settings. Then when you start the controller, put it in pairing mode, then hit the hotkey and your controller will connect and work properly. 
