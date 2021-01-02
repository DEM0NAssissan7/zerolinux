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
chmod +x /tmp/zerolinux/shells/date.sh
chmod +x /tmp/zerolinux/shells/partitioner.sh
chmod +x /tmp/zerolinux/shells/sysinstaller.sh
chmod +x /tmp/zerolinux/shells/appinstaller.sh
chmod +x /tmp/zerolinux/shells/bootloader.sh
chmod +x /tmp/zerolinux/shells/users.sh

#Executing the scripts
exec /tmp/zerolinux/shells/date.sh
exec /tmp/zerolinux/shells/partitioner.sh
exec /tmp/zerolinux/shells/sysinstaller.sh
exec /tmp/zerolinux/shells/appinstaller.sh
exec /tmp/zerolinux/shells/bootloader.sh
exec /tmp/zerolinux/shells/users.sh

#Finishing garbage
echo Installation finished!
echo Remove USB and press enter to reboot
read
reboot
