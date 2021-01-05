echo Enter your desired hostname
read -p "Hostname: " hname
echo $hname > /mnt/etc/hostname
echo Setting up users
echo
echo Set password for root
passwd -R /mnt
read -p "Type the name of the user you wish to use: " username
useradd -R /mnt -mg wheel $username
echo Set the password for $username
echo $username > /tmp/username.dat
passwd -R /mnt $username
useradd -R /mnt -g wheel admin
echo Configuring sudo...
echo "%wheel ALL=(ALL) ALL" >> /mnt/etc/sudoers
#echo "%sudo ALL=(ALL) ALL" >> /mnt/etc/sudoers
#echo "Defaults !tty_tickets" >> /mnt/etc/sudoers
