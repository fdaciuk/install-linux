# Pop_OS!

> Informações importantes para instalções gerais no Pop_OS!

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

---

## Montagem automática de SSD do tipo NVME

Se tiver mais de 2 SSD NVME, é preciso definir o file system usando UUID, ao invés do diretório em `/dev`. Para pegar o UUID do SSD, só rodar o comando abaixo:

```
ls -lha /dev/disk/by-uuid
```

Esse comando vai exibir o UUID de cada partição montada. Depois é s usar esse UUID no `/etc/fstab` para montar a partição na inicialização do sistema:

```
UUID=xxxx /media/storage ext4 defaults 0 0
```

---

## Configuração de atalhos do Gnome

O Pop troca os atalhos padrão para maximizar janelas (Super + seta cima), tendo que usar o `Ctrl` junto. Para ajustar, só pesquisar por `Keyboard Shortcuts`, buscar pelos atalhos, e fazer as substituições:

```
Move to workspace above: Ctrl + Alt + Up
Move to workspace below: Ctrl + Alt + Down
Restore window: Super + Down
Toggle maximization state: Super + Up
View split on left: Super + Left
View split on right: Super + Right
Move window one workspace down: Shift + Ctrl + Alt + Down
Move window one workspace up: Shift + Ctrl + Alt + Up
```

---

## Adicionar ícones no system tray

Só seguir os procedimentos [desse link](https://pop.system76.com/docs/status-icons/), e reiniciar o PC.

Instale a extensão:

```
sudo apt install gnome-shell-extension-appindicator
```

Reinicie o PC.

Ative a extensão pelo Gnome Tweaks, ou com o comando:

```
gnome-shell-extension-prefs
```

O nome da extensão deve aparecer como **Ubuntu AppIndicators** ou **KStatusNotifierItem/AppIndicator Support**. 
