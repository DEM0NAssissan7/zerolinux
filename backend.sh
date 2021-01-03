#!/bin/bash

clear
echo Welcome to the Zero Linux install script!
echo
echo -FYI- -This is not made for newbies-
echo
read -p "Press enter to continue..."
timedatectl set-ntp true
rm -r /tmp/zerolinux
cp -r ../zerolinux /tmp

#Chmodding the scripts
chmod +x /tmp/zerolinux/shells/*

#Executing the scripts
bash /tmp/zerolinux/shells/partitioner.sh
bash /tmp/zerolinux/shells/sysinstaller.sh
bash /tmp/zerolinux/shells/locales.sh
bash /tmp/zerolinux/shells/date.sh
bash /tmp/zerolinux/shells/users.sh
bash /tmp/zerolinux/shells/appinstaller.sh
bash /tmp/zerolinux/shells/bootloader.sh
bash /tmp/zerolinux/shells/settings.sh
bash /tmp/zerolinux/shells/final.sh
