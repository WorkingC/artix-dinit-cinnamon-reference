
# Installation and Applicaiton Setup

## Installation
The install media  media boots right into a Cinnamon environment with several things on the desktop. You can just install Artix from the icon. What matters to us is our system's partitioning. When you get to that section, opt for a manual partition. 
```
# Filesystem Setup
/boot/efi	  Fat32		  	flags: boot, bios-grub, 	512MB
swap		  linuxswap		flags: swap					Half of your RAM in MB. eg, 16GB RAM / 8192MB
/			  ext4 or brtfs								96GB (98304MB) to 128GB (131072MB)
/home		  ext4 or brtfs							    Remainder of storage. 
```
This will set your system up to be reinstall proof - you'll be able to install a different Linux distribution without wiping your home partition. 

## pacman and AUR Helpers

### pacman
Keep it simple:
```
sudo pacman -Syu   # Downloads and installs the newest updates.
sudo pacman -S <package>   # Downloads and installs an app.
sudo pacman -Rsn   # Removes a package, removes dependencies not required by other packages, and removes package backup files.
```
Be careful:
```
sudo pacman -Sc # Clears the package cache. This can be a problem if an update breaks an install and you need to downgrade it with pacman -U.
```
Do not:
```
sudo pacman -Sy   # Synchronizes the package database, but that can also lead to partial package updates which break systems. It's referenced a few times here in this guide, but those specific instances are the only safe times to use it.
sudo pacman -Rsc   # Removes a package, removes package dependencies, and removes packages that depend on the initial package. This can break systems.
```
Now's a good time to mention this, actually: the desktop environment and/or window manager you use is a committed install. That's not a formalized system thing, that's just a thing you Just Don't Mess With. Even though the DE is a package just like firefox, you shouldn't treat the DE package the same.

Yes, you can remove it, but doing so is never a completely clean affair unless you're intimately familiar with the total package group of a given DE. I have broken two Archlinux installations by being careless about this, and those were mercifully more kiosk-like installations than full home installs.

I hope you're doing your initial learning of Archlinux in a VM, because if you decide you want to have a new DE for some reason, it will be safest to completely reinstall a different Artix image and start over fresh. This is why my essential packages are listed the way they are in the First Boot section.

### Packages (Programs, Applications)
For Artix, you can browse and search the package database: 
https://packages.artixlinux.org/

#### wget > pacman -U
You can also directly install versions of packages direct from the Artix or Arch package archives using wget. If something breaks and you can determine what package and version it was, you can downgrade it. 
```
sudo pacman -S wget
```
These are package archives.
https://archive.artixlinux.org/
https://archive2.artixlinux.org/
https://archive.archlinux.org/
	
Fidnd the package you want, copy the .tar.zst url. And to install from them, the format looks like:
```
wget <url>
sudo pacman -U <packagename>
```
When you do this for Arch packages, please note that if you don't have the Arch package repositories open, those packages will not be able to be updated with pacman -Syu. 

### AUR Helpers
PER THE ARTIX WIKI, installing from Arch's repositories and the AUR, while possible, is not supported and may lead to some breakage. 

If you're looking around for packages to install, see a recommendation, then try to pacman -S it, then get stopped by "Target not found," you can use an AUR helper. Some of the apps I recommend later need an AUR to install, so while you're doing essential instealls, setup an AUR at that time.

First
```
sudo pacman -S --needed base-devel git
```
Then
```
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```
Then, any time pacman doesn't have a package, but the AUR helper does, run "paru -S" in place of "pacman -S". An AUR is a one time setup. After that, you use it just like pacman.

https://aur.archlinux.org/ has a complete searchable database of Linux applications that can be installed through AUR helpers.
Be mindful, this is community maintained, which means malignant packages can slip through the cracks. The rule of thumb is to check the PKGBUILD of the AUR installation before running the AUR command for it - but new end users wouldn't know what to look for. The other rule of thumb is to just not blindly install packages through AUR without checking feedback on it first.

If you try to run
```
yay -S package-name
```
and then get an immediate error like
```            
yay: error while loading shared libraries: libalpm.so.15: cannot open shared object file: No such file or directory
```
You'll need to rebuild and reinstall the AUR of choice.
```
# Remove old yay directory
rm -rf ~/yay

# Clone fresh
git clone https://aur.archlinux.org/yay.git ~/yay
cd ~/yay

# Build and install
makepkg -si
```
If you want to use an application without using the AUR, check the git AUR page of it. It will have a Git Clone URL. When you run this command, it will always drop the files in your root (/) directory, and the folder is always going to be named after the .git. I actually don't use AUR helpers, I git clone > cd > makepkg -si directly anything I pick off the AUR.
```
git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome
makepkg -si
```	
git clone drops the folder in your /home/<user> directory. 
			
When you want to check the software build before installing it for anything malicious, you can use 
```
less PKGBUILD
# Press q to exit the less viewer. 
```
## A list of recommended apps
These commands are written out in such a way that you can copy-paste (Shift+Ctrl+V in gnome-terminal) the line after the | to quickly begin an install. If you're reading this you probably *don't* know, don't blindly trust commands you see and copy and paste them. 

The following have Linux versions:
```
Brave | git clone https://aur.archlinux.org/brave-bin.git && cd brave-bin && makepkg -si
LibreWolf | sudo pacman -S librewolf
LibreOffice | sudo pacman -S libreoffice-fresh
XNViewMP | git clone https://aur.archlinux.org/xnviewmp.git && cd xnviewmp && makepkg -si
MPV | sudo pacman -S mpv
Tor | Download it from the Tor homepage: https://www.torproject.org/download/
Flashplayer Standalone | git clone https://aur.archlinux.org/flashplayer-standalone.git cd flashplayer-standalone && makepkg -si
```
The following are Windows applications, to(>) nearest Linux equivalents, and it's the reason those near equivalents chosen in the earlier essentials section:
```
Notepad++ > CudaText | git clone https://aur.archlinux.org/cudatext-gtk2-bin.git && cd cudatext-gtk2-bin.git && makepkg -si
Voidtools Everything > fsearch | git clone https://aur.archlinux.org/fsearch-git.git && cd fsearch-git && makepkg -si
```
Artix's Cinnamon install comes comes with Eye of Gnome, an image viewr like Microsoft Image Viewer, Nemo, a tabbed file browser, and a built-in PDF/ebook reader. 


## Specific App Details
### Tor:
  Download Tor from the official website. The download for linux is a portable application, so just unzip and drop it wherever in your file system. For my purposes, it's under /home/c/Documents/Portable Apps
  To make it an app in the system, open Terminal
  ```
  cd "/home/c/Documents/Portable Apps/tor-browser"
  ./start-tor-browser.desktop --register-app
  ```
  This makes it appear in your menu as a recognized app, which you can then pin to your taskbar.
  You can do this with any AppImage that runs on Linux.
        
  If you're using Tor to watch videos, you MUST install ffmpeg4.4!
  ```
  sudo pacman -S ffmpeg4.4
  ```

### Firefox Profiles:
  Manually drop your firefox profiles here.
  ```
  ~/.mozilla/firefox/
  ```
### Librewolf:
Manually drop your firefox profiles here. You may have to brute force getting your profile to work by editing profiles.ini
```
~/.librewolf/
```	
LibreWolf comes with some default settings that breaks uploads on certain websites (bluesky). Open about:config
```
privacy.resistFingerprinting = false
```
Remove title bar.
```
Click the 3 lines far right (usually under the X) to open the application menu.
Next, click on "More Tools" then "Customize toolbar...".
This will open a new tab. Uncheck "Title Bar" at the bottom left.
```
Fix diagonal tearing:
```
about:config
Search layers.acceleration.force-enabled
Default is false, set it true. 
```
### XnviewMP:
XNView does not follow the system color theming. Change it here:
```
Tools > Settings, General > Theme
```
User configs:
```
~/.config/xnview
```
### MPV :
User configs (no root needed):
```
~/.config/mpv/  
```
You will not have an mpv.conf or input.conf by default .
    
### Cudatext: 
If we want word wrap on by default: 
```
sudo cudatext /home/c/.config/cudatext/settings/user.json
```
Add this before the closing curly-brace:
```
"wrap_mode": 1
```
