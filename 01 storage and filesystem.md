# Storage and the File System
So drives mounted on the motherboard or plugged in via a USB will appear part of the browseable file system, but they're not *part* of the file system. You need to mount them to the file system so you can share or reference those locations. I'm also going to assume that the drives you're moving are are Windows NTFS storage drives. So we need to do this first:
```
sudo pacman -S ntfs-3g
```

Make the mountable directories:
```
sudo mkdir -p /mnt/Drive/C
sudo mkdir -p /mnt/Drive/D
```

Then run:
```
lsblk -f
```

This tells you what UUID each of your drives has, as well as the device handler that Linux references it. If you labeled these drives in Windows, they'll read that label in lsblk.
```
sudo nano /etc/fstab
```

Open up and add these lines to /etc/fstab
```
UUID=1234567890AB /mnt/Drive/C ntfs-3g rw,user,uid=1000,gid=1000,umask=000,allow_other,exec,nofail 0 0
UUID=CDEFGHIJKLMN /mnt/Drive/D ntfs-3g rw,user,uid=1000,gid=1000,umask=000,allow_other,exec,nofail 0 0
```

Explanation of options:
```
rw: Allows reading and writing.
nofail: Prevents boot errors if drive isn't connected
user: Allows regular users to mount/unmount
uid=1000,gid=1000: Makes your user account the owner (check your id with `id` command)
umask=000: Gives read/write permissions to everyone
allow_other: Allows other applications to access those drives.
exec: Allows applications to be executed from those drives. 
```
