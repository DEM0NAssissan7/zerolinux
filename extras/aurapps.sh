mv /mnt/etc/sudoers /tmp/
cp /tmp/zerolinux/extras/sudoers /mnt/etc/

#Install dependencies
arch-chroot /mnt pacman --noconfirm -Syu git meson libxss libpng12 openssl-compatibility

git clone https://aur.archlinux.org/google-chrome.git
mkdir /mnt/home/install
mv google-chrome /mnt/home/install/
chmod -R 777 /mnt/home/install/
echo "cd /home/install/google-chrome && sudo -u admin makepkg -sif" | arch-chroot /mnt 
rm -r /mnt/home/install

git clone https://aur.archlinux.org/gnome-shell-extension-appindicator.git
mkdir /mnt/home/install
mv gnome-shell-extension-appindicator /mnt/home/install/
chmod -R 777 /mnt/home/install/
echo "cd /home/install/gnome-shell-extension-appindicator && sudo -u admin makepkg -sif" | arch-chroot /mnt 
rm -r /mnt/home/install

git clone https://aur.archlinux.org/gnome-shell-extension-desktop-icons-ng.git
mkdir /mnt/home/install
mv gnome-shell-extension-desktop-icons-ng /mnt/home/install/
chmod -R 777 /mnt/home/install/
echo "cd /home/install/gnome-shell-extension-desktop-icons-ng && sudo -u admin makepkg -sif" | arch-chroot /mnt 
rm -r /mnt/home/install

cp /tmp/sudoers /mnt/etc/sudoers
