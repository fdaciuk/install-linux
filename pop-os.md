# Pop_OS!

> Informações importantes para instalações gerais no Pop_OS!

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
View split on left: Super + Left (por algum motivo esse atalho deixa de funcionar ao reiniciar)
View split on right: Super + Right (por algum motivo esse atalho deixa de funcionar ao reiniciar)
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

---

## Terminal
> Atalhos usados no terminal (Vim, ZSH e Tmux):

### ZSH
- Plugin `zsh-autosuggestions` instalado. Para completar um comando, pressionar seta para direita ou a tecla `End`.

**Copiar arquivos (usar no lugar do cp -R)**

Esse comando usa `rsync` por baixo dos panos para copiar arquivos. A diferença do `cp` é que ele vai exibir o progresso do que está acontecendo.

```
copy <origem> <destino>
```


### Vim (Neovim)
- Alias `vim` e `vi` configurados para abrir o `nvim`;
- Tecla `leader` é a vírgula;

**Carregar arquivo de configuração do Neovim (Edit Vim)**

```
<leader>ev
```

**Dar reload no arquivo de configuração (Source Vim)**

```
<leader>sv
```

**Comentar linhas**

```
<leader>/
```

OBS.: para comentar várias linhas de uma vez, só selecionar no modo visual:
- Pressione `v`;
- Selecione as linhas, com `j` para selecionar abaixo ou `k` para selecionar acima;
- Pressione as teclas para comentar (`<leader>/`).

**Remover highlight das buscas**

```
<leader><space>
```

**Buscar arquivos com Fuzzy Finder (estilo Sublime Text)**

```
Ctrl + P
```


### Tmux
- `prefix` definido como `Ctrl + j` ao invés do padrão `Ctrl + b`

**Iniciar sessão zero**

```
tmux
```

**Iniciar sessão com nome**

```
tmux new -s <nome-da-sessao>
```

**Sair do Tmux, mantendo as sessões**

```
<prefix>d
```

**Exibir todas as sessões criadas**

```
tmux ls
```

**Acessar a sessão mais recente**

```
tmux a

ou 

tmux attach
```

**Acessar sessão pelo nome ou número**

```
tmux a -t <nome-ou-numero-da-sessao>
```

**Criar painel (split) vertical**

```
<prefix>%
```

**Criar painel (split) horizontal**

```
<prefix>"
```

**Navegar pelos painéis (usando as teclas de navegação do Vim: h,j,k,l)**

```
Alt + <tecla-de-navegacao (h,j,k ou l)>

ou

<prefix><tecla-de-navegacao>
```

**Criar janelas (abas)**

```
<prefix>c
```

**Navegar entre janelas**

```
Ctrl + Alt + <tecla-de-navegacao>

ou 

<prefix> <numero-da-janela>
```

**Rolagem (scroll)**

```
<prefix>[
```
Após executar esse comando, é possível navegar no histórico com os comandos do vim.

**Zoom in/out no painel atual**

```
<prefix>z
```

**Navegar entre sessões, com um preview de cada sessão**

```
<prefix>s
```

**Navegar entre sessões, com um preview de cada janela em cada sessão**

```
<prefix>w
```
