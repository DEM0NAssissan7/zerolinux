res3=y
read -p "Do you wish to install the GRUB bootloader [In most cases, yes]: [Y/n] " res3
if [[ $res3 = "" ]]; then res3=y;fi
if [[ $res3 = y ]]; then
echo Installing bootloader
pacman -r /mnt --noconfirm -S efibootmgr grub
devins=`cat /tmp/devins`
arch-chroot grub-install
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
echo Finished installing the bootloader!
fi
echo Setting up startup services
pacman -r /mnt --noconfirm -S networkmanager
systemctl --root=/mnt enable NetworkManager
systemctl --root=/mnt enable gdm
echo
