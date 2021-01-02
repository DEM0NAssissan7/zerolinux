#!/bin/bash

echo Welcome to the reinstall script!
cp ./uninstall.sh /root
chmod +x /root/uninstall.sh
cd /root
rm -r zerolinux
git clone https://github.com/DEM0NAssissan7/zerolinux
chmod +x zerolinux/backend.sh
chmod +x zerolinux/reinstall.sh
echo Finished
