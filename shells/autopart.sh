read -p "Are you SURE you want to continue? [y/N] " res1
if [[ $res1 = "" ]];then res1=n;fi
if [[ $res1 = y ]];then
#exec code
echo Destroying data...
devins="/dev/sda"
if [[ /tmp/devins.dat ]]; then devins=`cat /tmp/devins.dat`; else devins="/dev/sda";fi
dd if=/dev/zero of=$devins  bs=512
echo Partitioning $devins"..."

echo Detecting boot type
if [[ /sys/firmware/efi ]]; then
echo Detected EFI system
system=efi
else
echo Detected BIOS system
system=bios
fi
echo Creating partitions
if [[ $system = efi ]];then
sfdisk $devins< /tmp/zerolinux/extras/efi.sfdisk
echo Formatting partitions
mkfs.fat -F 32 $devins"1"
mkfs.ext4 -F $devins"2"
echo Mounting partitions
mount $devins"2" /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount $devins"1" /mnt/boot/efi
fi

if [[ $system = bios ]];then
sfdisk < /tmp/zerolinux/extras/bios.sfdisk
echo Formatting partitions
mkfs.ext4 -F $devins"1"
mkfs.ext4 -F $devins"2"
echo Mounting partitions
mount $devins"2" /mnt
mkdir /mnt/boot
mount $devins"1" /mnt/boot
fi

echo Finished partitioning!
fi
