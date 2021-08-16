# Tmux

- [Meus dotfiles](https://github.com/fdaciuk/dotfiles)
- [Minhas configurações atuais](https://github.com/fdaciuk/install-linux/blob/master/pop-os.md)

---

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

**Alterar posição de painéis (definir layout vertical ou horizontal)**

```
<prefix>Alt + <1-5>
```

_O que faz cada número?_

| Número | Layout            | Descrição                                                                                                                                                   |
| :----: | ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `1`    | `even-horizontal` | Painéis em colunas                                                                                                                                          |
| `2`    | `even-vertical`   | Painéis em linhas                                                                                                                                           |
| `3`    | `main-horizontal` | Painéis em linhas, com o primeiro painel ocupando a linha toda, e os outros painéis na linha de baixo organizados em colunas (um ao lado do outro)          |
| `4`    | `main-vertical`   | Painéis em colunas, com o primeiro painel ocupando toda a primeira coluna, e os outros painéis na segunda coluna, organizados em linha (um abaixo do outro) |
| `5`    | `tiled`           | Divide os painéis para tentar deixá-los com a mesma largura / altura                                                                                        |

**Rolagem (scroll)**

```
<prefix>[
```

ou

```
<prefix><enter>
```

Após executar esse comando, é possível navegar no histórico com os comandos do vim, inclusive selecionar visualmente (V) e copiar (Y).

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

**Digitar o mesmo comando em vários painéis**

Primeiro abra várias painéis na mesma janela usando `<prefix>\` ou `<prefix>-` para abrir painéis horizontais e/ou verticais.

Quando todos os painéis estiverem prontos para receber os mesmos comandos, entre no modo de comandos do Tmux, com:

```
<prefix>:
```

E então digite o comando:

```
setw synchronize-panes on
```

E dê enter.

Agora ao digitar, você estará digitando em todos os painéis ao mesmo tempo!

Para parar a sincronização, entre novamente no modo de comandos do Tmux:

```
<prefix>:
```

E então digite:

```
setw synchronize-panes off
```

E dê enter.
