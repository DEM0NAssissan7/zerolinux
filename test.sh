#!/bin/bash

mkdir /mnt/home
mkdir /mnt/home/install
cp /tmp/zerolinux/extras/aurapps.sh /mnt/home/install/
chmod +x /mnt/install/aurapps.sh

useradd -R /mnt -g wheel admin

#arch-chroot /mnt bash /home/install/mawlspack-install.sh
arch-chroot /mnt bash /home/install/aurapps.sh
