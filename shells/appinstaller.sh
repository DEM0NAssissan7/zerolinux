stty tostop
stty -tostop
echo Installing Applications
echo
echo 1. Bones [Bare minimum to run the desktop]
echo 2. Minimal [Small set of apps]
echo 3. Standard [A general set of apps]
echo
read -p "Select which number to install [1,2,3]: " insnumber
echo You have selected option $insnumber
echo
if [[ $insnumber = 1 ]]; then
echo Installing Barebones...
bones=`cat /tmp/apps/bones.list`
pacman -r /mnt --noconfirm -S $bones
fi
if [[ $insnumber = 2 ]]; then
echo Installing Minimal...
bones=`cat /tmp/apps/bones.list`
minimal=`cat /tmp/apps/minimal.list`
pacman -r /mnt --noconfirm -S $bones $minimal
fi
if [[ $insnumber = 2 ]]; then
echo Installing Standard...
bones=`cat /tmp/apps/bones.list`
minimal=`cat /tmp/apps/minimal.list`
standard=`cat /tmp/apps/standard.list`
pacman -r /mnt --noconfirm -S $bones $minimal $standard
fi
echo Finished installing applications!
echo
exit
