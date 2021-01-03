echo Installing Applications
echo
echo 1. Bones [Bare minimum to run the desktop] [For advanced users]
echo 2. Minimal [Small set of apps] [For people who like more customizability]
echo 3. Standard [A general set of apps and tools] *Recommended
echo
read -p "Select which number to install [1 / 2 / 3]: " insnumber
echo You have selected option $insnumber
echo $insnumber > /tmp/insnumber.dat
echo
mkdir /mnt/home
mkdir /mnt/home/install
cp /tmp/zerolinux/extras/mawlspack-install.sh /mnt/home/install/
cp /tmp/zerolinux/extras/aurapps.sh /mnt/home/install/
chmod +x /mnt/install/mawlspack-install.sh
chmod +x /mnt/install/aurapps.sh

barecmd="arch-chroot /mnt pacman --noconfirm -S xorg-server xorg-xinit gnome-shell nautilus gnome-terminal gnome-control-center xdg-user-dirs gdm"
minicmd="arch-chroot /mnt pacman --noconfirm -S gnome-tweaks firefox nano gedit wget curl gnome-backgrounds gnome-calculator gnome-system-monitor gnome-icon-theme zsh"
standardcmd="arch-chroot /mnt pacman --noconfirm -S htop neofetch lm_sensors pavucontrol gnome-screenshot"

if [[ $insnumber != 2 && $insnumber != 3 ]];then
echo Installing Barebones...
bash -c $barecmd
arch-chroot /mnt bash /home/install/mawlspack-install.sh
fi
if [[ $insnumber = 2 ]]; then
echo Installing Minimal...
bash -c $barecmd
bash -c $minicmd
arch-chroot /mnt bash /home/install/mawlspack-install.sh
fi
if [[ $insnumber = 3 ]]; then
echo Installing Standard...
bash -c $barecmd
bash -c $minicmd
bash -c $standardcmd
arch-chroot /mnt bash /home/install/mawlspack-install.sh
arch-chroot /mnt bash /home/install/aurapps.sh
fi
rm -r /mnt/home/install
echo Finished installing applications!
echo
