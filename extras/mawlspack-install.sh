cd /tmp
wget https://github.com/DEM0NAssissan7/mawlspack/releases/download/1.1/mawlspack.zip
unzip mawlspack.zip
cd mawlspack
chmod +x install.sh
./install.sh
pacman -S gnome-shell-extensions
gsettings set org.gnome.desktop.interface gtk-theme "mawlspack-theme"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
gsettings set org.gnome.desktop.interface cursor-theme "mawlspack-cursor"
gsettings set org.gnome.shell.extensions.user-theme name "mawlspack-shell"
