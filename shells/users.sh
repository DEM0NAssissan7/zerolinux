echo Enter your desired hostname
read -p "Hostname: " hname
echo $hname > /mnt/etc/hostname
echo Setting up users
echo
echo Set password for root
passwd -R /mnt
read -p "Type the name of the user you wish to use: " username
useradd -R /mnt -mg sudo $username
echo Set the password for $username
passwd -R /mnt $username
echo Configuring sudo...
echo "%admins ALL=(ALL) ALL" >> /mnt/etc/sudoers
#echo "%sudo ALL=(ALL) ALL" >> /mnt/etc/sudoers
echo "Defaults !tty_tickets" >> /mnt/etc/sudoers
