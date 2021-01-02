echo Configuring locales...
echo en_US.UTF-8 UTF-8 >> /mnt/etc/locales.gen
echo en_US ISO-8859-1 >> /mnt/etc/locales.gen
echo Generating locales
locale-gen
echo LANG=en-US.UTF-8 > /mnt/etc/locale.conf
