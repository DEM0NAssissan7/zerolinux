echo Applying custom settings...
echo

#Theme
arch-chroot /mnt gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
arch-chroot /mnt gsettings set org.gnome.desktop.interface gtk-theme "mawlspack-theme"
arch-chroot /mnt gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
arch-chroot /mnt gsettings set org.gnome.desktop.interface cursor-theme "mawlspack-cursor"
arch-chroot /mnt gsettings set org.gnome.shell.extensions.user-theme name "mawlspack-shell"

#Fonts
cp -r /tmp/zerolinux/gnome-configs/ubuntu /usr/share/fonts/
arch-chroot /mnt gsettings set org.gnome.desktop.interface font-name "Ubuntu 11"
arch-chroot /mnt gsettings set org.gnome.desktop.interface document-font-name "Sans 11"
arch-chroot /mnt gsettings set org.gnome.desktop.interface monospace-font-name "Ubuntu Mono 13"

#Nautilus
arch-chroot /mnt gsettings set org.gnome.nautilus.preferences show-hidden-files true

# Ctrl-Alt-T Terminal Shortcut
arch-chroot /mnt gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
arch-chroot /mnt gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'
arch-chroot /mnt gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
arch-chroot /mnt gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Ctrl><Alt>t'

#Zsh
mkdir /mnt/home/install/
cp /tmp/zerolinux/gnome-configs/terminal-profile.dconf /mnt/home/install/
arch-chroot /mnt dconf dump /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < home/install/terminal-profile.dconf
cp -r /tmp/zerolinux/gnome-configs/.oh-my-zsh /mnt/root/
cp /tmp/zerolinux/gnome-configs/.zshrc /mnt/root/
arch-chroot /mnt chsh -s $(which zsh) $(whoami)
