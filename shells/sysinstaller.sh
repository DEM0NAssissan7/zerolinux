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
exit
