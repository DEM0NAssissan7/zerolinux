#!/bin/bash

echo Welcome to the Zero Linux install script!
echo
echo -FYI- -This is not made for newbies- -kinda-
echo
read -p "Press enter to continue..."
echo
rm -r /tmp/zerolinux
cp -r ../zerolinux /tmp

#Chmodding the scripts
chmod +x /tmp/zerolinux/nocrash.sh
chmod +x /tmp/zerolinux/shells/date.sh
chmod +x /tmp/zerolinux/shells/partitioner.sh
chmod +x /tmp/zerolinux/shells/sysinstaller.sh
chmod +x /tmp/zerolinux/shells/appinstaller.sh
chmod +x /tmp/zerolinux/shells/bootloader.sh
chmod +x /tmp/zerolinux/shells/users.sh

#Executing the scripts
bash /tmp/zerolinux/nocrash.sh
bash /tmp/zerolinux/shells/date.sh
bash /tmp/zerolinux/shells/partitioner.sh
bash /tmp/zerolinux/shells/sysinstaller.sh
bash /tmp/zerolinux/shells/appinstaller.sh
bash /tmp/zerolinux/shells/bootloader.sh
bash /tmp/zerolinux/shells/users.sh

#Finishing garbage
echo Installation finished!
echo Remove USB and press enter to reboot
read
reboot
