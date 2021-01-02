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
read -p "Enter the device you wish to install Zero Linux on: " devins
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
if [[ $efipart ]]; then mkfs.fat -F 32 $efipart;fi
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

echo Installing Base System
echo 
pacstrap /mnt base base-devel linux linux-firmware
echo
echo Generating fstab
genfstab -U /mnt >> /mnt/etc/fstab
echo
echo Loading install files into tmp file
cp -r apps /tmp/
echo
echo Installing extra software
echo
echo
echo
echo Updating pacman repositories
pacman -r /mnt --noconfirm -Syu
pacman -r /mnt --noconfirm -S networkmanager grub
echo systemctl enable NetworkManager | arch-chroot /mnt
echo

echo Installing Applications
echo
bones=`cat /tmp/apps/bones.list`
minimal=`cat /tmp/apps/minimal.list`
standard=`cat /tmp/apps/standard.list`
echo 1. Bones [Bare minimum to run the desktop]
echo 2. Minimal [Small set of apps]
echo 3. Standard [A general set of apps]
echo
read -p "Select which number to install [1,2,3]: " distro
echo You have selected option $distro
echo
if [[ $distro = 1 ]]; then
echo Installing Barebones...
pacman -r /mnt --noconfirm -S $bones
fi
if [[ $distro = 2 ]]; then
echo Installing Minimal...
pacman -r /mnt --noconfirm -S $bones $minimal
fi
if [[ $distro = 2 ]]; then
echo Installing Standard...
pacman -r /mnt --noconfirm -S $bones $minimal $standard
fi
echo Finished installing applications!
echo

res3=y
read -p "Do you wish to install the GRUB bootloader [In most cases, yes]: [Y/n] " res3
if [[ $res3 = y ]]; then
echo Installing bootloader
pacman -r /mnt --noconfirm -S efibootmgr
echo "grub-install $devins;grub-mkconfig -o /boot/grub/grub.cfg" | arch-chroot /mnt
echo Finished installing the bootloader!
fi

echo Set password for root
passwd -R /mnt
read -p "Type the name of the default user: " username
useradd -R /mnt -m $username
echo Set the password for $username
passwd -R /mnt $username

echo Installation finished!
echo Remove USB and press enter to reboot
read
reboot
