# Netowrk Shares / Samba Shares

## LAN Setup
We're going to manually arrange two devices in a LAN, where Device B can access and mount shares from Device A.

### Device A-1 (Windows Host)
- First, right click the folder > Give access too... > Advanced Sharing
- Tick "Sare this folder"
- Click the permissions button and give the read-write access your guests will have.

The Linux portions of this reference make the assumption that the guest will be given write access.

- Control Panel > Network Connections > Ethernet (the one you know connects both machines)
- Right Click > Properties

Navigate to TCP/ICP4 settings

Tick Use the Following IP Address:
IP:     10.0.0.1
Subnet: 255.255.255.0

### Device A-2 (Linux Host)
```
sudo pacman -S samba samba-dinit cifs-utils
sudo nano /etc/samba/smb.conf
```
In the text editor, make a basic global ruleset and your shares.
```
[global]
workgroup = MYGROUP
server role = standalone server
server string = Samba Server %v
netbios name = Petaton-Arch
security = user
map to guest = bad user

[Share Name]
path = /path/to/share
read only = no
browsable = yes
```
Test that your smb.conf is correct.
```		
testparm
```
Enable smbd and nmbd. 
```
sudo dinitctl start smbd
sudo dinitctl start nmbd
```
Setup a user that can login to the share. It must be a user that is on the system. 
```		
sudo smbpasswd -a username
```
Run testparm again and make sure everything's good. If it is, reload the ruleset.
```
sudo smbcontrol all reload-config
```
You should now be able to log in to smb shares from a guest without the host needing to reboot.

###  Device B (Linux Guest, Network-Manager-Applet)
Highlight Wired Connection (the one you know connects both machines), click the Gear icon
IPv4 Settings tab
Additional static IP addresses, Add

- IP:     10.0.0.2
- Netmask: 24
- Subnet: 255.255.255.0

The guest must have cifs-utils.
```
sudo pacman -S cifis-utils
```
On the guest device, the shares are accessed in the file browser (Nemo, Dolphin, Thunar) at smb://10.0.0.1, but they also need gvfs-smb
```
sudo pacman -S gvfs-smb
```

You do not have to do this to arrange any shares that are on Wifi. The method we'll do will mount shares assuming a static IP on Device A, which can be a regular LAN address (192.168.1.xxx). In that case, use yours in place of the sample address in the next section.
	
One other thing you can do - if you have the hostname of the device you want to connect to, you don't have to set the static IP up between the devices. You can instead use the hostname in place of the IP address. eg, instead of smb://10.0.0.1/c, use smb://windowshost/c

## cifs Automounted Shares
For our example, we'll assume you have 2 additional network drives, a D drive and an E drive.

Make locations to mount the shares in the file system.
```
sudo mkdir /mnt/Shares/D
sudo mkdir /mnt/Shares/E
```

Open nano and add the network locations to file system tab (fstab)
```
nano /etc/fstab

# Add these lines.
//10.0.0.1/c /mnt/Shares/D cifs username=cow,password=moo,uid=1000,gid=1000,users,iocharset=utf8,noauto,nofail,users,vers=3.0,soft,retrans=3,_netdev 0 0
//10.0.0.1/d /mnt/Shares/E cifs username=cow,password=moo,uid=1000,gid=1000,users,iocharset=utf8,noauto,nofail,users,vers=3.0,soft,retrans=3,_netdev 0 0
```

In the terminal:
```
testparm
```
If it's all good:
```
sudo mount -a
```

Let's break down the options:
```
username=cow
password=moo # self explanatory
uid=1000
gid=1000 # These declare the owner that owns all files and directories on the mounted share. 
iocharset=utf8 # this is the encoding of the response to the  queries the network will make when you try to connect.
noauto # doesn't automount the share.
nofail # doesn't stop the boot if there's an error. 
users # this makes it so any  user can freely unmount the network shares in file browsers without root access.
soft # Allows I/O to fail instead of hanging.
retrans=3 # Number of retries before failing
_netdev #Wait for network to be available.
```

## Credentials
But wait, cries the experienced Linux user who realizes that we're putting another device's user login and password, fstab is plain text, even if you need root access to edit it. So we'll go over putting credentials in a file that requires root to even view it. 

In the terminal: 
```
sudo mkdir -p /etc/samba
sudo nano /etc/samba/credentials

user=cow
password=moo
```

Save it. Now we set it so it's read accessible by users. Back to terminal:
```
sudo chmod 600 /etc/samba/credentials
```

Back to fstab:
```
//10.0.0.1/c /mnt/Shares/D cifs credentials=/etc/samba/credentials,uid=1000,gid=1000,users,iocharset=utf8,noauto,nofail,users,vers=3.0,soft,retrans=3,_netdev 0 0
//10.0.0.1/d /mnt/Shares/E cifs credentials=/etc/samba/credentials,uid=1000,gid=1000,users,iocharset=utf8,noauto,nofail,users,vers=3.0,soft,retrans=3,_netdev 0 0
```

Test if it's all good.
```
sudo mount -a
```
Reboot, you should still be able to log into your shares.
