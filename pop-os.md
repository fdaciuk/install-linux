# Informações importantes para drivers no Pop_OS!

## Instalação do adaptador wireless TP-Link TL-WN8200ND

> Link: https://askubuntu.com/questions/1078953/drivers-for-tp-link-tl-wn8200nd-v2

**Passo-a-passo da solução para Kernel >=5:**

Install kernel-headers, build-essentials, git, binutils and dkms packages:

```
sudo apt install -y linux-headers-$(uname -r) build-essential git binutils dkms
```

Then, download the driver and install:

```
git clone https://github.com/clnhub/rtl8192eu-linux.git
cd rtl8192eu-linux/
./install_wifi.sh
```

## Montagem automática de SSD do tipo NVME

Se tiver mais de 2 SSD NVME, é preciso definir o file system usando UUID, ao invés do diretório em `/dev`. Para pegar o UUID do SSD, só rodar o comando abaixo:

```
ls -lha /dev/disk/by-uuid
```

Esse comando vai exibir o UUID de cada partição montada. Depois é s usar esse UUID no `/etc/fstab` para montar a partição na inicialização do sistema:

```
UUID=xxxx /media/storage ext4 defaults 0 0
```
