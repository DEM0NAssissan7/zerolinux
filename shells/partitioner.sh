lsblk
echo
read -p "Enter the device you wish to install Zero Linux on: " devins
$devins >> /mnt/devins
echo Entering partitioner...
cfdisk $devins
echo
echo Select partitions to format
lsblk
echo
read -p "Select the partition to install your root partition [REQUIRED]: " rootpart
echo
echo If any of these are not required, leave blank
echo You MUST have one
read -p "Enter the /boot partition: " bootpart
read -p "Enter the EFI partition: " efipart
echo
echo Next are optional mounts
resp1=n
read -p "Are home or swap partitions required? [y/N]" resp1
if [[ $resp1 = "y" ]]; then
read -p "Enter the /home partition: " homepart
read -p "Enter the swap partition [NOT SUPPORTED]: " swappart
fi
read -p "Are you SURE these drives are correct? [ENTER] "
echo Formatting partitions...
mkfs.ext4 -F $rootpart
if [[ $bootpart ]]; then mkfs.ext4 -F $bootpart;fi
if [[ $efipart ]]; then mkfs.fat -F 32 $efipart;fi
if [[ $homepart ]]; then mkfs.ext4 -F $homepart;fi
#if [[ $swappart ]]; then mkfs.ext4 $swappart;fi
echo
echo Mounting partitions
mount $rootpart /mnt
mkdir /mnt/boot
if [[ $bootpart ]]; then mount $bootpart /mnt/boot;fi
if [[ $efipart ]]; then 
	mkdir /mnt/boot/efi
	mount $efipart /mnt/boot/efi
fi
if [[ $homepart ]]; then 
	mkdir /mnt/home 
	mount $homepart /mnt/home
fi
echo
