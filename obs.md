# OBS 
For games

## Prerequisites
```
wget https://archive.archlinux.org/packages/o/obs-studio/obs-studio-32.1.2-5-x86_64.pkg.tar.zst
sudo pacman - U obs-studio-32.1.2-5-x86_64.pkg.tar.zst

git clone https://aur.archlinux.org/obs-vkcapture-git.git
cd obs-vkcapture-git
makepkg -si
```

## Setup Kernel Options
```
sudo nano /etc/modprobe.d/nvidia-drm-modeset.conf
```
Put this line in, save it, close it.
```
options nvidia_drm modeset=1
```
Update init-ram.
```
sudo mkinitcpio -P
```

## Steam Game
In the Steam game's properties, you need to add env 'OBS_VKCAPTURE=1 obs-gamecapture' to the launch options line before '%command%'.
```
OBS_VKCAPTURE=1 obs-gamecapture %command%
```
Now in OBS, you can add a game capture. It will grab any winow that has 'obs-gamecapture' in its launch options. 
