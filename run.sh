#!/bin/bash

clear
echo Welcome to the Zero Linux install
echo
echo To revert any step, type 'back' at any time
read -p "Press [ENTER] to continue "
if [[ /tmp/zerolinux ]]; then rm -r /tmp/zerolinux;fi
cp -r ../zerolinux /tmp
loop=true
step=0

#Function vars
app=3
drive=sda
auto=n
rootpart=/dev/sda2
bootpart=
efipart=
username=
userpass=
rootpass=

function appins {
echo
echo Select which installation would you like to use
echo
echo 1. Barebones: The bare minimum to run the desktop [For advanced users]
echo 2. Minimal: A small set of basic apps [For users who want customizability]
echo 3. Standard: A set of useful tools and apps [Recomended]
echo
read -p "Which would you like to install [1, 2, 3]: " app
if [[ $app = back ]]; then
step=0
else
step=1
fi
}

function partition {
echo
lsblk | grep -i "disk"
read -p "Which drive would you like to install Zero Linux on [eg. /dev/sda] /dev" drive
if [[ $drive = back ]];then
step=0
else
stepint=1
fi
echo
read -p "Would you like to automate the partitioning [THIS WILL DESTROY THE DATA ON THE SELECTED DRIVE] [y/N] " auto
if [[ $auto = back ]]; then
step=0
fi
if [[ $auto = y || $auto = Y ]]; then

devins=/dev/$drive
#Copied from autopart





echo Destroying data...
dd if=/dev/zero of=$devins  bs=512  count=1
echo Partitioning $devins"..."
echo Detecting boot type
if [[ /sys/firmware/efi ]]; then
echo Detected EFI system
system=efi
else
echo Detected BIOS system
system=bios
fi
echo Creating partitions

if [[ $system = efi ]];then
sfdisk $devins< /tmp/zerolinux/extras/efi.sfdisk
echo Formatting partitions
mkfs.fat -F 32 $devins"1"
mkfs.ext4 -F $devins"2"
echo Mounting partitions
mount $devins"2" /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount $devins"1" /mnt/boot/efi
fi

if [[ $system = bios ]];then
sfdisk < /tmp/zerolinux/extras/bios.sfdisk
echo Formatting partitions
mkfs.ext4 -F $devins"1"
mkfs.ext4 -F $devins"2"
echo Mounting partitions
mount $devins"2" /mnt
mkdir /mnt/boot
mount $devins"1" /mnt/boot
fi






echo Partitioning complete!
step=2
else
echo Opening partitioner
cfdisk /dev/$drive
echo
echo Select partitions to format
lsblk | grep -i "part"
echo
read -p "Select the partition to install your root partition [REQUIRED]: " rootpart
echo
echo If any of these are not required, leave blank
echo You MUST have one
if [[ /sys/firmware/efi ]]; then
read -p "Enter the EFI partition: " efipart
else
read -p "Enter the /boot partition: " bootpart
fi
echo
echo Next are optional mounts
resp1=n
read -p "Are home or swap partitions required? [y/N]" resp1
if [[ $resp1 = "y" ]]; then
read -p "Enter the /home partition: " homepart
read -p "Enter the swap partition [NOT SUPPORTED]: " swappart
fi
resp3=y
read -p "Are you SURE these drives are correct? [Y/n] " resp3
if [[ $resp3 = y || $resp3 = Y ]];then
echo Formatting partitions...
mkfs.ext4 -F $rootpart
if [[ $bootpart ]]; then mkfs.ext4 -F $bootpart;fi
if [[ $efipart ]]; then mkfs.fat -F 32 $efipart;fi
if [[ $homepart ]]; then mkfs.ext4 -F $homepart;fi
#if [[ $swappart ]]; then mkfs.ext4 $swappart;fi
echo
echo Mounting partitions
mount $rootpart /mnt
mkdir /mnt/boot
if [[ $bootpart ]]; then mount $bootpart /mnt/boot;fi
if [[ $efipart ]]; then 
	mkdir /mnt/boot/efi
	mount $efipart /mnt/boot/efi
fi
if [[ $homepart ]]; then 
	mkdir /mnt/home 
	mount $homepart /mnt/home
fi
echo
fi
else
step=0
fi
}

function users {
stepint=0
echo
if [[ $stepint = 0 ]]
echo Type back at any time to go to the previous option
read -p "Enter the name of your user [eg. jhon]: " username
read -sp "Enter the password for your user: " userpass
echo
read -p "Enter the name you wish for your computer to have [eg. the-cool-computer]: "
echo
read -sp "Enter the password for root [leave blank to make it the same as the user]: " rootpass
}

#Loop
while [[ $loop = true ]]; then

if [[ $step = 0 ]]; then
appins
fi

if [[ $step = 1 ]]; then
partition
fi

if [[ $step = 2 ]]; then
users
fi
