# Pop!\_OS

> Informações importantes para instalações gerais no Pop!\_OS v21.04

## Passo a passo inicial

- Instalar o sistema;
- Se no tiver conexão com internet, usar Android com USB Tethering conectado em uma rede wifi;
- Atualizar o sistema: `sudo apt update && sudo apt upgrade -y`;
- Instalar adaptador wireless (próximo passo).

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

## Como usar o roteador TP-Link Archer C6 1200AC como adaptador wireless ou repetidor, via wireless, sem conectar cabo no modem principal

> A ideia aqui é utilizar o roteador TP-Link em um PC que não tem placa wireless, ligando direto na placa de rede da placa mãe, consumindo a wifi direto do roteador principal, sem usar cabos para conectar os dois roteadores.

**Importante:**
_Esse roteador da TP-Link é Gigabit, ou seja, suporta velocidades acima de 100mbs (até 1000mbs). Se você tem uma internet contratada com essa velocidade ou superior, e quer usufruir de toda essa velocidade, seu roteador principal precisa conseguir servir o wifi a 5ghz acima dessa velocidade, a placa de rede do seu PC também precisa ser Gigabit (10/100/1000) para suportar velocidades acima de 100mbs, e você também vai precisar de um cabo de rede Gigabit, para ligar no PC (o cabo acompanha o roteador da TP-Link)._

Esse roteador da TP-Link não funciona muito bem em 2.4ghz. Ao menos comigo, a velocidade da internet fica em torno de 20% do valor total, e dificilmente passa disso. Então vou mostrar como configurá-lo para ser usado na frequência de 5ghz.

Faça a configuração inicial do TP-Link, com ele conectado ao PC pelo cabo de rede. Quando for para selecionar o tipo de acesso, deixe como _Router_. **Não mude** para _Access Point_. 

Ao acessar a interface do roteador, a primeira coisa a fazer é colocar o IP dele no mesma faixa de IP do roteador principal. Exemplo: o IP padrão do TP-Link é 192.168.0.1, e o meu roteador principal está em 192.168.100.1. Vamos deixar o TP-Link no IP 192.168.100.2.

Para isso, clique na aba _Advanced_, depois no menu _Network_, na opção _LAN_. Modifique o _IP Address_ para ficar na mesma faixa do seu roteador principal. No meu caso, o valor desse campo vai ser 192.168.100.2. Ao clicar em _Save_, o roteador irá reiniciar. Aguarde a nova tela de login, agora no novo endereço.

Com os dois roteadores na mesma faixa de IP, agora vamos conectar o TP-Link na wifi do roteador principal. Clique novamente na guia _Advanced_, vá até o menu _System Tools_ e clique em _System Parameters_.

Role até a sessão _5GHz WDS_, clique para habilitar o checkbox _Enable WDS Bridging_, depois clique no botão _Survey_. As redes 5ghz disponíveis devem aparecer. Se a sua rede não aparecer, verifique a porta das redes que aparecem, e altere a porta da rede 5ghz do modem principal, para ficar dentro da faixa que o TPLink consegue enxergar.

Então, ao cliar em _Survey_ sua rede 5G deve aparecer. Conecte na rede clicando no link _Choose_, coloque a senha da sua rede 5ghz e clique em _Save_.

Com isso feito, só falta mais um passo: - **lembrando que esse passo deve ser feito só ao final de toda a configuração** - clique em _Network > DHCP Server_ e desabilite a opção _Enable DHCP Server_. Salve e reinicie o roteador, clicando no botão _Reboot_ no topo da página.

Ao reiniciar, você já deve estar com acesso a internet \o/

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
Switch focus to left monitor: Disabled
Switch focus to right monitor: Disabled
Switch focus to window down: Disabled
Switch focus to window left: Disabled
Switch focus to window right: Disabled
Switch focus to window up: Disabled
Move to workspace above: Ctrl + Alt + Up
Move to workspace below: Ctrl + Alt + Down
Move window one workspace down: Shift + Ctrl + Alt + Down
Move window one workspace up: Shift + Ctrl + Alt + Up
Lock screen: Super + L
Maximize window: Super + Up
Restore window: Super + Down
View split on left: Super + Left
View split on right: Super + Right

```

## Definir input e output padrões no pulseaudio (quando não salva a alteração após o reboot)
https://rastating.github.io/setting-default-audio-device-in-ubuntu-18-04/

---

## Rolagem pela trackball no Logitech MX Ergo

Aqui vamos precisar de duas dependências: `xinput` e `solaar`.

**Configuração do `xinput`:**
https://www.reddit.com/r/Trackballs/comments/lwvyk9/mx_ergo_trackball_scrolling_in_linux/gpjykaz/?utm_source=reddit&utm_medium=web2x&context=3

> If you're using `X11` and `xinput`:
> 
> find the id / name of the input device from this command: `xinput`
>
> enable the feature with this magic command: 
>
```
xinput set-prop <id or name of trackball> 'libinput Scroll Method Enabled' 0, 0, 1
```

---
O comando provavelmente vai ser:
```
xinput set-prop pointer:"Logitech MX Ergo" 'libinput Scroll Method Enabled' 0, 0, 1
```
---

>
> Not sure if this will work as you want, but libinput has a lot of settings you can play with -- list them with `xinput list-props <device id>`
>
> If you're happy with the settings and want to make them permanent you can add them to a config file: as root create a file at ` /etc/X11/xorg.conf.d/10-mx-ergo-scroll-trackball.conf` and put something like this in it:

```
Section "InputClass"
	Identifier "<name of the device>"
	Driver "libinput"
	Option "ScrollMethod" "button"
EndSection
```

> The option names can be found in the manual: `man 4 libinput`
>
> If you're on wayland... idk good luck!

Após fazer essa configuração, o scroll com a trackball estará funcionando ao pressionar e segurar o botão do meio do mouse (scroll). Para usar o botão "Forward" no lugar, abra o Solaar e configure o botão "Forward" para funcionar como o "Mouse Middle Button".

### Opções para wayland (não testado)
- https://www.reddit.com/r/Trackballs/comments/lwvyk9/mx_ergo_trackball_scrolling_in_linux/gpwsn3k/?utm_source=reddit&utm_medium=web2x&context=3
- https://www.reddit.com/r/Trackballs/comments/lwvyk9/mx_ergo_trackball_scrolling_in_linux/gpt8lah/?utm_source=reddit&utm_medium=web2x&context=3
- https://www.reddit.com/r/Trackballs/comments/brfs0k/logitech_mx_ergo_stiff_middle_button/eoqgvkq?utm_source=share&utm_medium=web2x&context=3

--

## Configuração do Jack para áudio

Instalar pacotes:

```
sudo apt install qjackctl pulseaudio-module-jack
```

Iniciar o QJackCtl, e definir em `Setup > Options > Execute script after Startup` o seguinte comando:

```
pacmd set-default-sink jack_out
```

Depois, iniciar os módulos para o Pulseaudio redirecionar a entrada e saída de áudio para o Jack:

```
pactl load-module module-jack-sink
pactl load-module module-jack-source
```

E pronto! Para configurar a saída de áudio para "mono", na interface do Jack vá até `Connect` e, na aba `Audio`, 
conecte todos os canais do lado esquerdo `PulseAudio Jack Sink` com os canais `system` do lado direito.

---

## Adicionar ícones no system tray (válido somente para a v19.10. Na v20.04 ou posterior isso já vem instalado).

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

---

## Suporte para apps Snap

```
sudo apt update
sudo apt install snapd
```

---

## Softwares adicionais para instalar

**Alacritty (terminal que roda sobre a GPU)**
> Importante lembrar que, até o momento, o Alacritty não suporta emojis.

```
sudo add-apt-repository ppa:mmstick76/alacritty
sudo apt udpate
sudo apt install alacritty
```

Copie o arquivo `alacritty.yml` para a raiz da sua /home/seu_usuario.

**Htop**

```
sudo apt install htop
```

**NVM**
https://github.com/nvm-sh/nvm

**Yarn**
https://classic.yarnpkg.com/en/docs/install#debian-stable

```
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
```

```
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
```

```
sudo apt update && sudo apt install --no-install-recommends yarn
```

**asdf**
https://github.com/asdf-vm/asdf

- [Getting Started](https://asdf-vm.com/guide/getting-started.html)

Baixe o `asdf`:

```
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
```

Para instalar o `asdf` com ZSH + oh-my-zsh, é só baixar [o plugin](https://github.com/kiurchv/asdf.plugin.zsh):

```
git clone https://github.com/kiurchv/asdf.plugin.zsh $HOME/.oh-my-zsh/custom/plugins/asdf
```

**asdf para Erlang**
https://github.com/asdf-vm/asdf-erlang

Dependências necessárias:

```
sudo apt install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
```

Instale do plugin do Erlang:
```
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
```

Instale o Erlang:

```
asdf install erlang latest
```

Defina como a versão "global":

```
asdf global erlang latest
```

Use `asdf list` para conferir se o Erlang aparece na listagem.

**asdf para Elixir**
https://github.com/asdf-vm/asdf-elixir

Instale o Elixir:

```
asdf install elixir latest
```

Defina como a versão "global":

```
asdf global elixir latest
```

Use `asdf list` para conferir se o Elixir aparece na listagem.

**Psensor (software gráfico para sensores de temperatura do hardware)**

Instalação do `lm-sensors`:
```
sudo apt install lm-sensors
```

Iniciar detecção do hardware (rode o comando abaixo e responda `yes` ou `no` para as questões:
```
sudo sensors-detect
```

Verifique se está funcionando:
```
sensors
```

O comando acima deve exibir algo como:
```
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +46.0C  (high = +76.0C, crit = +100.0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +44.0C  (high = +76.0C, crit = +100.0C)

...
```

Depois, só instalar o `psensor`:
```
sudo apt install psensor
```

**GreenWithEnvy (monitoramento de GPUs Nvidia)**

Como instalar: https://sempreupdate.com.br/greenwithenvy-saiba-instalar-no-ubuntu-fedora-debian-centos-e-opensuse-faca-overclock-em-gpus-nvidia/

Instale o flatpak (se ainda não tiver instalado):
```
sudo apt install flatpak
```

Adicione o flathub (só para a v19.10. Já vem instalado na v20.04):
```
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

Reinicie a sessão, e então instale o GreenWithEnvy:

```
flatpak install flathub com.leinardi.gwe
```

**Conky (outros monitoramentos do hardware)**

Instale o conky e o appmenu-gtk3-module:

```
sudo apt install conky appmenu-gtk3-module
```

Copie o diretório `conky` daqui do repo para dentro do diretório `~/.config`. Para iniciar o conky, execute o arquivo que está em `bin/start-conky`.

**Telegram Desktop**

Só baixar o executável, colocar em qualquer lugar que você queira manter, e executar. Automaticamente será gerado um arquivo `telegramdesktop.desktop`, com um atalho no Gnome.

**Slack Desktop**

Também só baixar o `.deb` e executá-lo, ou clicando duas vezes, ou com o comando:

```
sudo dpkg -i <caminho-do-arquivo.deb>
```

**Insomnia**

```
# Add to sources
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list

# Add public key used to verify code signature
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | sudo apt-key add -

# Refresh repository sources and install Insomnia
sudo apt-get update
sudo apt-get install insomnia
```

**Postgres**
https://www.postgresql.org/download/linux/ubuntu/

```
sudo apt install postgresql postgresql-contrib
```

**Importante:** Se instalar o dbeaver via apt, ao atualizar o dbeaver-ce, baixando direto do site o arquivo `.deb`, ao rodar `sudo apt upgrade`, o apt vai tentar fazer DOWNGRADE da versão mais recente para a vesão do repositório. Para manter a versão mais recente, é preciso rodar o comando abaixo:

```
sudo apt-mark hold dbeaver-ce
```

Então o melhor é instalar o **dbeaver-ce** via snap, que já tem a versão mais recente:

```
sudo snap install dbeaver-ce
```

Criar senha para o usuário postgres:

```
sudo su - postgres
psql
```

Dentro do psql, digitar `\password` e entrar com a senha.

Sair com `\q`.

Depois disso, só entrar com:

```
psql -h localhost -U postgres
```

---

## Terminal

> Se estiver usando o terminal padrão do Gnome, você pode exportar / importar suas configurações seguindo as orientações [desse gist](https://gist.github.com/fdaciuk/9ec4d8afc32063a6f74a21f8308e3807).

### Instalação do Neovim

```
sudo apt install neovim
```

Para instalar a versão stable mais recente, use o [PPA](https://launchpad.net/~neovim-ppa/+archive/ubuntu/stable):

```
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
```

- Instale o `curl` e `wget` se ainda não o tiver feito;
- Crie o diretório de configuração do neovim em `~/.config/nvim`;
- Instale o [vim plug](https://github.com/junegunn/vim-plug) para gerenciamento de plugins, no diretório `~/.config/nvim/autoload`, com o comando:

```
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

- Crie o arquivo de configuração `~/.config/nvim/init.vim`, copiando [desse repo](https://github.com/fdaciuk/dotfiles);
- Inicie o neovim com o comando `nvim`;
- Instale os plugins, com o comando `:PlugInstall` (dentro do vim);
- Feche o vim e abra novamente.

Ao iniciar o nvim (com o comando `nvim`, ou só `vim`, se já tiver configurado o alias para isso), será pedida a chave da API do wakatime. Acesse [sua conta](https://wakatime.com/vim) e cole a chave ali.

Se a barra de status do vim parecer "estranha", e não tiver as setinhas do Powerline, mais abaixo tem instruções de como instalar as fontes do Powerline corretamente. Teremos Powerline tanto no vim como no Tmux :)

### Instalação ZSH, Neovim e Tmux

**ZSH e Oh-my-ZSH**

Instale o ZSH:
```
sudo apt install zsh
```

Defina o ZSH como shell principal:
```
chsh -s $(which zsh)
```

Reinicie a sessão para entrar com o ZSH por padrão.

Ao iniciar o terminal, responda a pergunta com a opção 2.

Instale o oh-my-zsh:
```
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Instale o tema `avit-da2k`:
https://github.com/fdaciuk/avit-da2k


Instale o plugin zsh-autosuggestions:
https://github.com/zsh-users/zsh-autosuggestions

```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Instale o plugin zsh-wakatime:
https://github.com/wbingli/zsh-wakatime

É necessário ter o `pip` instalado. Para instalá-lo para a versão 3 do Python:

```
sudo apt install python3-pip
```

Após instalar, reinicie o terminal para ter acesso ao comando `pip3`.

Instale a CLI do wakatime:

```
pip3 install wakatime
```

Reinicie o terminal novamente.

Instale o zsh-wakatime:

```
cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/wbingli/zsh-wakatime.git
```

Adicione no `~/.zshrc`, na parte de plugins, o autosuggestion e o wakatime:

```
plugins=(git zsh-autosuggestions zsh-wakatime)
```

Se o arquivo foi copiado aqui do repo, já deve estar com essa entrada.

Instale o autojump:

```
sudo apt install autojump
```

Após a instalação, reinicie o terminal, ou execute:

```
sorce ~/.zshrc
```

### Instalação do Tmux
https://github.com/tmux/tmux

```
sudo apt install tmux
```

Para instalar o oh-my-tmux:
https://github.com/gpakosz/.tmux

Importante lembrar de ativar o Powerline para funcionar corretamente:
https://github.com/gpakosz/.tmux#enabling-the-powerline-look

Aqui nesse link você encontra várias fontes com suporte para Powerline:
https://github.com/powerline/fonts

Clone o repositório e execute o script `install.sh`. Agora reinicie o terminal e pronto!

---

## Atalhos usados no terminal (Vim, ZSH e Tmux):

### ZSH

https://github.com/fdaciuk/install-linux/blob/master/zsh-shortcuts-and-cheatsheet.md

---

### Vim (Neovim)

https://github.com/fdaciuk/install-linux/blob/master/vim-shortcuts-and-cheatsheet.md

---

### Tmux

https://github.com/fdaciuk/install-linux/blob/master/tmux-shortcuts-and-cheatsheet.md

---

## Solução de problemas

Ao tentar gravar no OBS com uma placa Nvidia, as vezes fica passando uma imagem na tela da janela que está atrás. [Nesse link](https://obsproject.com/forum/threads/screen-tearing-obs-preview.25977/) contém a descrição do problema.

Para resolver, só entrar nas configs da Nvidia (Nvidia X Server Settings), selecionar "OpenGL Settings" e desligar a opção "Allow Flipping".

### Problema com atualização de driver da Nvidia

Faça logout, e pressione `Ctrl + Alt + 3`. Isso vai abrir um _tty_.

Então, tente rodar o comando:

```
sudo dpkg --configure -a
```

Se o erro persistir, tente:

```
sudo apt --fix-broken install
```

Se estiver dando um erro do dpkg, e logo depois um erro mostrando várias versões da nvidia, use os comandos:

```
sudo apt autoremove
sudo apt install -f
```

Se após esses comandos o dpkg conseguir finalizar corretamente a configuração, basta reiniciar:

```
sudo reboot
```

Não resolvendo, tem que partir pra força bruta. execute os comandos:

```
sudo apt purge '*nvidia*'
sudo apt purge '*nvidia*:i386'
sudo apt clean
audo apt update -m
sudo dpkg --configure -a
sudo apt install -f
sudo apt dist-upgrade

# Só execute o comando abaixo se o comando anterior não retornar nenhum erro
sudo apt autoremove --purge
```

Feito isso, reinicie o PC.
Se logar automaticamente, deslogue novamente, entre no _tty_ e digite:

```
sudo apt --fix-broken install
sudo apt install g++-9-multilib pop-desktop system76-driver-nvidia system76-cuda-latest
```

Se a instalação do `system76-driver-nvidia` falhar, tentar rodar:

```
sudo apt install -f
sudo apt --fix-broken install
```

Depois disso, só tentar instalar novamente.

Após isso, tudo deverá estar resolvido. Se não estiver, tente todos os passos novamente. 

Então instale as atualizações:

```
sudo apt update
sudo apt upgrade -y
flatpak update -y
```
