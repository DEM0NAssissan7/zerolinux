echo Setting time and date
ls /mnt/usr/share/zoneinfo
echo Choose your region
read -p "Region [eg. America]: " rgn
echo
ls /mnt/usr/share/zoneinfo/$rgn
echo Choose your time zone
read -p "Time zone [eg. Chicago]: " tmz
echo Linking to installation
arch-chroot /mnt ln -sf /usr/share/zoneinfo/$rgn/$tmz /etc/localtime
echo
