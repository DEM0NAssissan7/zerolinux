#!/bin/bash

echo Welcome to the Zero Linux install script!
echo
echo -FYI- -This is not made for newbies- -kinda-
echo
read -p "Press enter to continue..."
echo
echo Select your date and time
#Insert some weird way to do date and time
echo
lsblk
echo
read "Enter the device you wish to install Zero Linux on: " devins
echo Entering partitioner...
cfdisk $devins
echo
echo Select partitions to format
lsblk
echo
read -p "Select which partition you wish to install your root partitions [REQUIRED]: " rootpart
echo
echo If any of these are not required, leave blank
read -p "Enter the /boot partition [REQUIRED]: " bootpart
read -p "Enter the EFI partition [REQUIRED]: " efipart
echo
echo Next are optional mounts
resp1=n
read -p "Are home or swap partitions required? [y/N]" resp1
if [[ $resp1 = "y" ]]; then
read -p "Enter the /home partition: " homepart
read -p "Enter the swap partition [NOT SUPPORTED]: " swappart
fi
echo Formatting partitions...
mkfs.ext4 $rootpart
if [[ $bootpart ]]; then mkfs.ext4 $bootpart;fi
if [[ $efipart ]]; then mkfs.vfat $efipart;fi
if [[ $homepart ]]; then mkfs.ext4 $homepart;fi
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
echo Installing base system
echo 
pacstrap /mnt base base-devel linux linux-firmware
echo
echo Generating fstab
genfstab -U /mnt >> /mnt/etc/fstab
echo
echo Installing extra software
echo
echo Loading install files into tmp file
mkdir /mnt/tmp
cp -r apps /mnt/tmp/
echo
arch-chroot /mnt
yes | pacman -S networkmanager grub
systemctl enable NetworkManager
echo
echo Installing Base System
echo
bones=`cat /tmp/apps/bones.list`
minimal=`cat /tmp/apps/minimal.list`
standard=`cat /tmp/apps/standard.list`
echo 1. Bones [Bare minimum to run the desktop]
echo 2. Minimal [Small set of apps]
echo 3. Standard [A general set of apps]
echo
while [[ $distro != "" ]]; do
read -p "Select which number to install" distro
done
echo You have selected option $distro
echo Updating pacman repositories
y | pacman -Syu
echo

if [[ $distro = 1 ]]; then
echo Installing Barebones...
y | pacman -S $bones
fi

if [[ $distro = 2 ]]; then
echo Installing Minimal...
y | pacman -S $bones $minimal
fi

if [[ $distro = 2 ]]; then
echo Installing Standard...
y | pacman -S $bones $minimal $standard
fi

echo
echo Finished installing applications!
echo
echo Install bootloader
grub-install $devins
grub-mkconfig -o /boot/grub/grub.cfg
echo
echo Set password for root
passwd
echo
read -p "Type the name of the default user: " username
useradd -m $username
echo Set the password for $username
passwd $username
exit
echo Installation finished!
echo Remove USB and press enter to reboot
read
reboot
