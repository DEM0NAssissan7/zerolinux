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
