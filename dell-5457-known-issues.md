# Problemas conhecidos

## Instalação passo-a-passo do Ubuntu Gnome 16.04

Entrar na BIOS, e resetar as configurações para configurações de fábrica (Factory settings);

Dar boot via pendrive e instalar normalmente, com o cabo de rede plugado, já que o wifi nao será reconhecido ainda;

Quando chegar na hora de selecionar as partições, não remover as que já existem. Só altere a partição onde está o Ubuntu 14.04, deixando o espaço que você precisar;

Deixe o grub no `/dev/sda`;

Após a instalação, o boot deverá carregar normalmente. Acesse o terminal, faça a atualização do sistema e a instalação dos pacotes básicos para continuar a instalação:

```sh
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install ubuntu-restricted-extras git 
```

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

```console
sudo apt-get update
sudo apt-get install git
git clone https://github.com/kvalo/ath10k-firmware.git
sudo mkdir /lib/firmware/ath10k/QCA9377
sudo mkdir /lib/firmware/ath10k/QCA9377/hw1.0
cd ath10k-firmware/QCA9377/hw1.0
sudo cp *  /lib/firmware/ath10k/QCA9377/hw1.0
cd /lib/firmware/ath10k/QCA9377/hw1.0
sudo mv firmware-5.bin_WLAN.TF.1.0-00267-1  firmware-5.bin
```

Reboot and your wireless should be working.

> fonte: http://askubuntu.com/questions/763080/no-wifi-in-qualcom-atheros-ubuntu-16-04-acer-aspire-e-15

---

## Passo 2:

solução do problema foi essa:

```
sudo mkdir -p /lib/firmware/ath10k/QCA6174/hw3.0/

sudo rm /lib/firmware/ath10k/QCA6174/hw3.0/* 2> /dev/null

sudo wget -O /lib/firmware/ath10k/QCA6174/hw3.0/board.bin https://github.com/FireWalkerX/ath10k-firmware/blob/7e56cbb94182a2fdab110cf5bfeded8fd1d44d30/QCA6174/hw3.0/board-2.bin?raw=true

sudo wget -O /lib/firmware/ath10k/QCA6174/hw3.0/firmware-4.bin https://github.com/FireWalkerX/ath10k-firmware/blob/7e56cbb94182a2fdab110cf5bfeded8fd1d44d30/QCA6174/hw3.0/firmware-4.bin_WLAN.RM.2.0-00180-QCARMSWPZ-1?raw=true

sudo chmod +x /lib/firmware/ath10k/QCA6174/hw3.0/*
```

reinicie o notebook e deve funcionar!

> fonte: https://www.vivaolinux.com.br/topico/Rede-Wireless/Alguem-me-ajude-wifi-ubuntu-1604?pagina=2
