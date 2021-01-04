echo Installation finished!
echo Remove installation media and press [ENTER] to reboot
read
rm -r /mnt/home/install
umount -R /mnt
reboot
