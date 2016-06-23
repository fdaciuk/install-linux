#!/bin/bash
set -eo pipefail

sudo mkdir -p /lib/firmware/ath10k/QCA6174/hw3.0/
sudo rm /lib/firmware/ath10k/QCA6174/hw3.0/* 2> /dev/null
sudo wget -O /lib/firmware/ath10k/QCA6174/hw3.0/board.bin https://github.com/FireWalkerX/ath10k-firmware/blob/7e56cbb94182a2fdab110cf5bfeded8fd1d44d30/QCA6174/hw3.0/board-2.bin?raw=true
sudo wget -O /lib/firmware/ath10k/QCA6174/hw3.0/firmware-4.bin https://github.com/FireWalkerX/ath10k-firmware/blob/7e56cbb94182a2fdab110cf5bfeded8fd1d44d30/QCA6174/hw3.0/firmware-4.bin_WLAN.RM.2.0-00180-QCARMSWPZ-1?raw=true
sudo chmod +x /lib/firmware/ath10k/QCA6174/hw3.0/*
