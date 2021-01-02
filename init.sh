#!/bin/bash

chmod +x zerolinux/backend.sh
chmod +x zerolinux/reinstall.sh
stty tostop
nohup backend.sh </dev/null &
bash backend.sh
