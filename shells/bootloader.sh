res3=y
read -p "Do you wish to install the GRUB bootloader [In most cases, yes]: [Y/n] " res3
if [[ $res3 = y ]]; then
echo Installing bootloader
pacman -r /mnt --noconfirm -S efibootmgr grub
echo "grub-install $devins;grub-mkconfig -o /boot/grub/grub.cfg" | arch-chroot /mnt
echo Finished installing the bootloader!
fi
echo Installing network manager
pacman -r /mnt --noconfirm -S networkmanager
#systemctl --root=/mnt enable NetworkManager
exit
