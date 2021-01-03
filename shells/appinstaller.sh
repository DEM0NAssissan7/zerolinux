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
chmod +x /mnt/home/install/mawlspack-install.sh
chmod +x /mnt/home/install/aurapps.sh

barecmd="pacman --noconfirm -S xorg-server xorg-xinit gnome-shell nautilus gnome-terminal gnome-control-center xdg-user-dirs gdm"
minicmd="pacman --noconfirm -S gnome-tweaks firefox gedit curl gnome-backgrounds gnome-system-monitor gnome-icon-theme zsh"
standardcmd="pacman --noconfirm -S htop neofetch lm_sensors pavucontrol gnome-screenshot gnome-calculator nano wget"

#if [[ $insnumber != 2 && $insnumber != 3 ]];then
if [[ $insnumber = 1 ]];then
echo Installing Barebones...
arch-chroot /mnt sudo -s -H $barecmd
fi

if [[ $insnumber = 2 ]]; then
echo Installing Minimal...

arch-chroot /mnt sudo -s -H $barecmd
arch-chroot /mnt sudo -s -H $minicmd

arch-chroot /mnt bash /home/install/mawlspack-install.sh
fi
if [[ $insnumber = 3 ]]; then
echo Installing Standard...

arch-chroot /mnt sudo -s -H $barecmd
arch-chroot /mnt sudo -s -H $minicmd
arch-chroot /mnt sudo -s -H $standardcmd

arch-chroot /mnt bash /home/install/mawlspack-install.sh
arch-chroot /mnt bash /home/install/aurapps.sh
fi
rm -r /mnt/home/install
echo Finished installing applications!
echo
