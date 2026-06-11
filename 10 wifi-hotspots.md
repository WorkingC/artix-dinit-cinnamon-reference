# Wifi Hotspots
## Prerequisits
You need hostapd and dnsmasq to run wifi hotspots. 
```
sudo pacman -S hostapd dnsmasq
```
If you're trying to setup a 5G hotspot on your system, you need to set your locale on iw so that 5G networks aren't blocked. 
```
sudo iw reg set US
```
This setting does not persist. We'll address that shortly.

## Create a wifi hotspot. 
```
nmcli connection add type wifi ifname wlan0 con-name "MyHotspot" autoconnect no ssid "MyNetwork" band a password "mypassword"
```
Once you verify your hotpsot works, we'll go to making it persistent. 

## Persistence
By default, the Linux kernel sets the system iw region to global. Without getting into the legalese of it, this means that trying to add or start a 5G wifi conneciton will fail. The most straightfoward way to do this is to set the iw region in GRUB, before the system boots proper. 

First, edit GRUB:
```
sudo nano /etc/default/grub
```
Find the line "GRUB_CMDLINE_LINUX_DEFAULT=...". Between the quotes, add the following line:
```
cfg80211.ieee80211_regdom=US
```
Update GRUB, then reboot.
```	
sudo update-grub
loginctl reboot
```
Note - I have not tested this on a dual-boot setup that loads into Windows, so I don't know if this will negatively impact any wifi hotspots you might try to setup on that side. 

Now, in Cinnamon, go to System Settings > Startup Applications, and add an application. It's a single line:
```	
nmcli connection up "MyHotspot"
```
Give it a delay of a second or two so the desktop environment is fully initialized before you start passing startup commands. 
