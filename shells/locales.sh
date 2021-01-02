echo Configuring locales...
echo en_US.UTF-8 UTF-8 >> /mnt/etc/locale.gen
echo en_US ISO-8859-1 >> /mnt/etc/locale.gen
locale-gen
echo LANG=en-US.UTF-8 > /mnt/etc/locale.conf
