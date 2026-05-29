# GRUB
A quick reference on setting up GRUB for multi-boot, multiple kernels, and cleaning up themes. 

Remember, in all instances of using nano, you can use a GUI application instead, but you must be sudo. 
## Get GRUB to see other operating systems. (For Multi-boot)
Open up the terminal.
```
sudo pacman -S os-prober
```
Uncomment a line in the grub settings. 
```
sudo nano /etc/default/grub

"GRUB_DISABLE_OS_PROBER=false"
```
Regenerate GRUB
```
sudo update-grub
```
## Add an additional kernel
Install the zen or lts kernel
```
sudo pacman -S linux-zen linux-zen-headers linux-lts linux-lts-headers
```
Add to grub boot options
```
sudo update-grub
reboot
```
After the reboot, you should be able to select the new kernel under advanced options. When you login, verify you're using the zen kernel. Artix automatically runs fastfetch, which includes the kernel version, but you can also run a command for it.
```
uname -r
```
## Tidiness
All of these configurations are in /etc/default/grub

By default, GRUB sits for 5 seconds with no input, before automatically booting into Linux. You can change the countdown timer.
```
GRUB_TIMEOUT=3
```
You can set GRUB to remember your last boot option by default. Useful once you've selected the zen kernel or went back to the regular kernel, and need to be using those kernels to configure and test things in a series of reboots. 
```
GRUB_DEFAULT="saved"
GRUB_SAVEDEFAULT="true"
```
You can also set it so it always starts on a specific option in the menu. This starts at 0 for the first option, then counts up as you go down the list.
```
GRUB_DEFAULT=1
# If your additional kernel ends up in the advanced options, it selects options in each index.
# If Advanced Options is the second item in the menu, it's 1, and then the kernel you want to automatically boot into is first, it's 0.
GRUB_DEFAULT=1>0
```
Artix installed by the GUI installer, by default, sets an Artix theme and colors for GRUB. You can disable those so it's a minimal bootloader. Comment out the following lines. 
```
#export GRUB_COLOR_NORMAL
#export GRUB_COLOR_HIGHLIGHT
#GRUB_BACKGROUND
#GRUB_THEME
```
Remember, any option you change, regenerate GRUB.
```
sudo update-grub
```
