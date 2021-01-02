echo Setting up users
echo
echo Set password for root
passwd -R /mnt
read -p "Type the name of the user you wish to use: " username
useradd -R /mnt -mg wheel $username
echo Set the password for $username
passwd -R /mnt $username
echo Configuring sudo...
