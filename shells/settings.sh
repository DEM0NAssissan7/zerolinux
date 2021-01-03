echo Applying custom settings...
echo
insnumber=`cat /tmp/insnumber.dat`
username=`cat /tmn/username.dat

#Theme
if [[ insnumber = 2 || insnumber = 3 ]]; then
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface gtk-theme "mawlspack-theme"
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface icon-theme "Papirus"
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface cursor-theme "mawlspack-cursor"
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.shell.extensions.user-theme name "mawlspack-shell"

#Favorite Apps
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.shell favorite-apps ['firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop']

#Fonts
arch-chroot /mnt pacman --noconfirm -S freetype2 fontconfig cairo
cp -r /tmp/zerolinux/gnome-configs/ubuntu /usr/share/fonts/
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface font-name "Cantarell 11"
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface document-font-name "Sans 11"
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface monospace-font-name "Monospace 13"
rm -r /home/install
mkdir /mnt/home/*/.config
mkdir /mnt/home/*/.config/fontconfig
cp /tmp/zerolinux/gnome-configs/fonts.conf /mnt/home/*/.config/fontconfig/

#Locales
arch-chroot /mnt localedef -f UTF-8 -i en_US en_US.UTF-8

#Minimize, Maximize
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

#Zsh
mkdir /mnt/home/install/
cp /tmp/zerolinux/gnome-configs/terminal-profile.dconf /mnt/home/install/
arch-chroot /mnt sudo -u $username dconf dump /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < home/install/terminal-profile.dconf
cp -r /tmp/zerolinux/gnome-configs/.oh-my-zsh /mnt/root/
rm -r /home/install
cp /tmp/zerolinux/gnome-configs/.zshrc /mnt/home/*/
arch-chroot /mnt sudo -u $username chsh -s $(which zsh) $(whoami)

fi

#Mouse Sensitivity
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'

#Nautilus
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.nautilus.preferences show-hidden-files true

# Ctrl-Alt-T Terminal Shortcut
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Ctrl><Alt>t'
