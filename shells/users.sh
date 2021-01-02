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

