# Problemas conhecidos

Instalação da placa wireless:

```
description: Wireless interface
product: QCA6174 802.11ac Wireless Network Adapter
vendor: Qualcomm Atheros
```

## Passo 1:

our driver requires firmware that is missing:

    Direct firmware load for ath10k/QCA9377/hw1.0/firmware-5.bin failed with error -2

With a working internet connection by ethernet, tethered or whatever means possible, please open a terminal and do:

sudo apt-get update
sudo apt-get install git
git clone https://github.com/kvalo/ath10k-firmware.git
sudo mkdir /lib/firmware/ath10k/QCA9377
sudo mkdir /lib/firmware/ath10k/QCA9377/hw1.0
cd ath10k-firmware/QCA9377/hw1.0
sudo cp *  /lib/firmware/ath10k/QCA9377/hw1.0
cd /lib/firmware/ath10k/QCA9377/hw1.0
sudo mv firmware-5.bin_WLAN.TF.1.0-00267-1  firmware-5.bin

Reboot and your wireless should be working.

> fonte: http://askubuntu.com/questions/763080/no-wifi-in-qualcom-atheros-ubuntu-16-04-acer-aspire-e-15

---

## Passo 2:

solução do problema foi essa:

sudo mkdir -p /lib/firmware/ath10k/QCA6174/hw3.0/

sudo rm /lib/firmware/ath10k/QCA6174/hw3.0/* 2> /dev/null

sudo wget -O /lib/firmware/ath10k/QCA6174/hw3.0/board.bin https://github.com/FireWalkerX/ath10k-firmware/blob/7e56cbb94182a2fdab110cf5bfeded8fd1d44d30/QCA6174...

sudo wget -O /lib/firmware/ath10k/QCA6174/hw3.0/firmware-4.bin https://github.com/FireWalkerX/ath10k-firmware/blob/7e56cbb94182a2fdab110cf5bfeded8fd1d44d30/QCA6174...

sudo chmod +x /lib/firmware/ath10k/QCA6174/hw3.0/*

reinicie o notebook e deve funcionar!

> fonte: https://www.vivaolinux.com.br/topico/Rede-Wireless/Alguem-me-ajude-wifi-ubuntu-1604?pagina=2
