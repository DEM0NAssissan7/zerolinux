echo Installing Applications
echo
echo 1. Bones [Bare minimum to run the desktop]
echo 2. Minimal [Small set of apps]
echo 3. Standard [A general set of apps]
echo
read -p "Select which number to install [1 / 2 / 3]: " insnumber
echo You have selected option $insnumber
echo
mkdir /mnt/home
mkdir /mnt/home/install
cp /tmp/zerolinux/extras/mawlspack-install.sh /mnt/home/install/
cp /tmp/zerolinux/extras/aurapps.sh /mnt/home/install/
chmod +x /mnt/install/mawlspack-install.sh
chmod +x /mnt/install/aurapps.sh
if [[ $insnumber = 1 ]]; then
echo Installing Barebones...
bones=`cat /tmp/apps/bones.list`
arch-chroot /mnt pacman --noconfirm -S xorg-server xorg-xinit gnome-shell nautilus gnome-terminal gnome-tweaks gnome-control-center xdg-user-dirs gdm
arch-chroot /mnt bash /home/install/mawlspack-install.sh
fi
if [[ $insnumber = 2 ]]; then
echo Installing Minimal...
bones=`cat /tmp/apps/bones.list`
minimal=`cat /tmp/apps/minimal.list`
arch-chroot /mnt pacman --noconfirm -S xorg-server xorg-xinit gnome-shell nautilus gnome-terminal gnome-tweaks gnome-control-center xdg-user-dirs gdm firefox nano gedit wget curl gnome-backgrounds gnome-calculator gnome-screenshot gnome-system-monitor gnome-icon-theme
arch-chroot /mnt bash /home/install/mawlspack-install.sh
fi
if [[ $insnumber = 3 ]]; then
echo Installing Standard...
bones=`cat /tmp/apps/bones.list`
minimal=`cat /tmp/apps/minimal.list`
standard=`cat /tmp/apps/standard.list`
arch-chroot /mnt pacman --noconfirm -S xorg-server xorg-xinit gnome-shell nautilus gnome-terminal gnome-tweaks gnome-control-center xdg-user-dirs gdm firefox nano gedit wget curl gnome-backgrounds gnome-calculator gnome-screenshot gnome-system-monitor gnome-icon-theme htop neofetch lm_sensors pavucontrol
arch-chroot /mnt bash /home/install/mawlspack-install.sh
arch-chroot /mnt bash /home/install/aurapps.sh
fi
rm -r /mnt/home/install
echo Finished installing applications!
echo
