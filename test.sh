#!/bin/bash

mkdir /mnt/home
mkdir /mnt/home/install
cp /tmp/zerolinux/extras/mawlspack-install.sh /mnt/home/install/
cp /tmp/zerolinux/extras/aurapps.sh /mnt/home/install/
chmod +x /mnt/install/mawlspack-install.sh
chmod +x /mnt/install/aurapps.sh

arch-chroot /mnt bash /home/install/mawlspack-install.sh
arch-chroot /mnt bash /home/install/aurapps.sh
