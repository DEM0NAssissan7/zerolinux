echo Applying custom settings...
echo
insnumber=`cat /tmp/insnumber.dat`
username=`cat /tmp/username.dat`

if [[ $insnumber = 2 || $insnumber = 3 ]]; then

#Theme
echo Applying theme settings
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface gtk-theme "mawlspack-theme"
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface icon-theme "Papirus"
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface cursor-theme "mawlspack-cursor"
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.shell.extensions.user-theme name "mawlspack-shell"

#Favorite Apps
echo Setting favorite apps
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.shell favorite-apps ['firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop']

#Fonts
echo Configuring fonts
arch-chroot /mnt pacman --noconfirm -Sq freetype2 fontconfig cairo
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface font-name "Cantarell 11"
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface document-font-name "Sans 11"
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface monospace-font-name "Monospace 13"
rm -r /mnt/home/install
mkdir /mnt/home/$username/.config
mkdir /mnt/home/$username/.config/fontconfig
cp /tmp/zerolinux/gnome-configs/fonts.conf /mnt/home/$username/.config/fontconfig/

#Minimize, Maximize
echo Configuring Minimize and Maximize
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

#Zsh
echo Configuring ZSH
mkdir /mnt/home/install/
cp /tmp/zerolinux/gnome-configs/terminal-profile.dconf /mnt/home/install/
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session dconf dump /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < /home/install/terminal-profile.dconf
cp -r /tmp/zerolinux/gnome-configs/.oh-my-zsh /mnt/root/
rm -r /home/install
cp /tmp/zerolinux/gnome-configs/.zshrc /mnt/home/$username/
arch-chroot /mnt chsh -s $(which zsh) $(whoami)

fi

#Locales
echo Configuring GNOME locales
arch-chroot /mnt localedef -f UTF-8 -i en_US en_US.UTF-8

#Mouse Acceleration
echo Adjusting mouse settings
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'

#Nautilus
echo Configuring Nautilus
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.nautilus.preferences show-hidden-files true

# Ctrl-Alt-T Terminal Shortcut
echo Configuring Terminal Shortcut
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
arch-chroot /mnt sudo -u $username dbus-launch --exit-with-session gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Ctrl><Alt>t'
echo
echo Finished applying settings!
