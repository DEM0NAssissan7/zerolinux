echo
read -p "Do you have an AMD or NVIDIA graphics card? [y/N] " apples
if [[ $apples = Y || $apples = y ]];then
read -p "Which graphics card [NVIDIA/amd]: " gc
if [[ $gc = amd || $gc = AMD ]]; then
echo Installing AMD graphics drivers...
arch-chroot /mnt pacman --noconfirm -S xf86-video-amdgpu vulkan-radeon libva-mesa-driver mesa-vdpau
else
echo Installing NVIDIA graphics drivers...
arch-chroot /mnt pacman --noconfirm -S nvidia nvidia-settings xorg-server-devel opencl-nvidia
fi
echo Done installing graphics drivers
fi
