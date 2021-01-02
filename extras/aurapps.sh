git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome
sudo -u guest makepkg -si
cd ..
rm -r google-chrome

git clone https://aur.archlinux.org/gnome-shell-extension-appindicator.git
cd gnome-shell-extension-appindicator
sudo -u guest makepkg -si
cd ..
rm -r gnome-shell-extension-appindicator
