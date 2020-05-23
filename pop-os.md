# Pop!\_OS

> Informações importantes para instalações gerais no Pop!\_OS v20.04

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

Role até a sessão _5GHz WDS_, clique para habilitar o checkbox _Enable WDS Bridging_, depois clique no botão _Survey_. As redes 5ghz disponíveis devem aparecer. Se a sua rede não aparecer, e seu modem for igual ao meu, tem uma configuração extra que precisa ser feita no roteador principal.

Meu roteador principal é um Huawei HG8245Q2. Para que eu pudesse ver a rede 5ghz à partir do TP-Link, eu precisei habilitar uma opção em _WLAN > Wifi Coverage Management_ chamada "_Synchronize WLAN to the external AP"_. É o primeiro checkbox que aparece nessa tela. _AP_ significa _Access Point_, que no caso, é o segundo roteador.

Ao fazer isso, esperei reiniciar o roteador principal, e então ao cliar em _Survey_ eu consegui ver minha rede 5G. Conecte na rede clicando no link _Choose_, coloque a senha da sua rede 5ghz e clique em _Save_.

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

## Adicionar ícones no system tray (válido somente para a v19.10. Na v20.04 isso já vem isntalado).

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
sudo snap install insomnia
```

**Postgres**
https://www.postgresql.org/download/linux/ubuntu/

```
sudo apt install postgresql postgresql-contrib dbeaver-ce
```

**Importante:** Ao atualizar o dbeaver-ce, baixando direto do site o arquivo `.deb`, ao rodar `sudo apt upgrade`, o apt vai tentar fazer DOWNGRADE da versão mais recente para a vesão do repositório. Para manter a versão mais recente, é preciso rodar o comando abaixo:

```
sudo apt-mark hold dbeaver-ce
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

- Instale o `curl` e `wget` se ainda não o tiver feito;
- Crie o diretório de configuração do neovim em `~/.config/nvim`;
- Instale o [vim plug](https://github.com/junegunn/vim-plug) para gerenciamento de plugins, no diretório `~/.config/nvim/autoload`, com o comando:

```
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

- Crie o arquivo de configuração `~/.config/nvim/init.vim`, copiando aqui do repo;
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
pip install wakatime
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
- Plugin `zsh-autosuggestions` instalado. Para completar um comando, pressionar seta para direita ou a tecla `End`.

**Copiar arquivos (usar no lugar do cp -R)**

Esse comando usa `rsync` por baixo dos panos para copiar arquivos. A diferença do `cp` é que ele vai exibir o progresso do que está acontecendo.

```
copy <origem> <destino>
```

**Copiar conteúdo de arquivos para o clipboard**

```
copy-to-cliboard <caminho-do-arquivo>
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

**Comentar várias linhas sem usar o modo visual**

- `10<leader>/`: comenta 10 linhas conta à partir da linha atual

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
Ctrl + p
```

**Buscar buffers abertos com o Fuzzy Finder**

```
Ctrl + o
```

**Navegar entre buffers**

- `go` = Lista todos os buffers e aceita um novo buffer como argumento
- `gh` = Lista todos os buffers e aceita um novo buffer como argumento, que será aberto em um split horizontal
- `gv` = Lista todos os buffers e aceita um novo buffer como argumento, que será aberto em um split vertical
- `Ctrl + 6` ou `gp` = Alterna entre os dois últimos buffers

**Rodar um comando em todos os buffers**

```
:bufdo <comando>
```

Exemplo:

- `:bd`: fecha o buffer atual
- `:bufdo bd`: fecha todos os buffers
- `:e!`: atualiza o buffer atual, ignorando as alterações não salvas
- `:bufdo e!`: atualiza todos os buffers, ignorando as alterações não salvas

**Símbolos usados na lista de buffers**

- `%`: buffer na janela atual
- `#`: buffer que pode ser alternado com o atual, usando `Ctrl + 6`
- `a`: buffer ativo, carregado e visível
- `h`: buffer oculto, carregado, mas não visível
- `-`: um buffer que não pode ser modificado _(modifiable off)_
- `=`: um buffer somente leitura
- `+`: um buffer com alterações que precisam ser salvas
- `x`: um buffer com erros de leitura
- ` `: se não houver um indicador no buffer, significa que ele ainda não foi carregado

**Zoom in ([z]oom [in])**
```
zin
```

**Zoom out ([z]oom [n]ot [i]n)**
> Não use `zo` aqui pois conflita com o atalho de folding.
```
zni
```

**Indentação de várias linhas à partir da atual (onde o cursor está)**

- `44>>`: indenta 44 linhas
- `10<<`: volta a indentação de 10 linhas

**Modificar valores (find & replace)**

1. Faça a busca do valor com `/valor`;
2. Pressione `cgn` no primeiro local onde você quer substituir;
3. Digite o novo valor;
4. Navegue para o próximo valor com `n` e use o `.` para substituir;
5. Repita o passo `4` até substituir todas as entradas que você quiser substituir.

Obs.: O comando `cgn` significa:
- `c`: Aguarda um movimento após esse comando. O movimento que vier após o `c` será deletado, e então entrará no modo INSERT.
- `gn`: Seleciona o _pattern_ mais recente usado na busca, usando o modo VISUAL. Vai servir como movimento para o atalho anterior `c`.
- Em resumo: a palavra buscada vai ser deletada, e o vim vai entrar no modo de inserção para digitar a sibstituição.
- O `n` é para navegar para o próximo match do valor buscado;
- O `.` repete o último comando (no caso, o `cgn` e a nova palavra).

#### Folding

Sabe aqueles editores que tem um botão de "-" ao lado da linha onde começa uma função ou tag HTML (ou JSX)? E quando você clica, todo o código dentro dessa função é "compactado", ou "fechado", mostrando somente as linhas antes e depois desse código? Isso se chama **folding!**. E dá pra fazer isso no Vim :D

**Folding em tags HTML ou JSX**

1. Posicione o cursor a linha que inicia a tag onde você quer fazer o fold;
2. Execute o comando `zaf`. Isso vai criar um "fold" para aquela tag, e vai trazer fechado.
3. Para abrir, pode usar `za` (toggle fold) ou `zo` (open fold).
4. Para cada novo fold, é preciso usar o `zaf`, senão, ao usar os comandos para abrir / fechar, esses serão aplicados
sempre no último fold criado. Após ter criado um "fold", sempre que quiser abrir / fechar algum em específico, é só
posicionar o cursor na linha onde inicia,e pressionar `zc` (close fold) ou `za`.

**Folding em funções**

1. Selecione as linhas da função que você quer fazer o fold, e crie o fold com `zfat` (ou `zfit`). Depois é só 
usar os comandos acima para abrir / fechar o fold conforme a necessidade :)

### Tmux
- `prefix` definido como `Ctrl + b`

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
<prefix>\

ou

<prefix>%
```

**Criar painel (split) horizontal**

```
<prefix>-

ou

<prefix>"
```

**Navegar pelos painéis (usando as teclas de navegação do Vim: h,j,k,l)**

```
Alt + <tecla-de-navegacao (h,j,k ou l)>

ou

<prefix><tecla-de-navegacao>
```

**Alterar tamanho dos painéis**

```
<prefix>H
<prefix>J
<prefix>K
<prefix>L
```

**Criar janelas (abas)**

```
<prefix>c
```

**Criar nova sessão**

```
<prefix>Ctrl + c
```

**Navegar entre janelas**

```
Ctrl + Alt + <tecla-de-navegacao>

ou 

<prefix> <numero-da-janela>
```

**Rotacionar / mover painéis**

```
<prefix>{
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

**Navegar entre sessões, com um preview de cada sessão, janela e painel**

```
<prefix>s
```

**Renomear janela**

```
<prefix>,

ou 

<prefix>:rename-window
```

**Renomear sessão**

```
<prefix>$

ou 

<prefix>:rename-session
```

**Listar todas as keybindings definidas no tmux**

```
tmux list-keys
```

## Solução de problemas

Ao tentar gravar no OBS com uma placa Nvidia, as vezes fica passando uma imagem na tela da janela que está atrás. [Nesse link](https://obsproject.com/forum/threads/screen-tearing-obs-preview.25977/) contém a descrição do problema.

Para resolver, só entrar nas configs da Nvidia (Nvidia X Server Settings), selecionar "OpenGL Settings" e desligar a opção "Allow Flipping".
