# ZSH

- [Meus dotfiles](https://github.com/fdaciuk/dotfiles)
- [Minhas configurações atuais](https://github.com/fdaciuk/install-linux/blob/master/pop-os.md)

---

- Plugin `zsh-autosuggestions` instalado. Para completar um comando, pressionar seta para direita ou a tecla `End`.

**Copiar arquivos (usar no lugar do cp -R)**

Esse comando usa `rsync` por baixo dos panos para copiar arquivos (`rsync -a --stats --progress`, pra ser mais exato). 
A diferença desse comando para o `cp` é que o `copy` vai exibir o progresso do que está acontecendo.

```
copy <origem> <destino>
```

Para fazer cópia de um arquivo local para um servidor SSH, só usar:

```
copy <origem> <ssh-user>@<ssh-server-ip-or-domain>:<destino>
```

Exemplo:

```
copy ./config-files/* deploy@meuserver.com:/home/my-project/config-files/
```

**Copiar conteúdo de arquivos para o clipboard**

```
copy-to-cliboard <caminho-do-arquivo>
```

**Sudo**

Podemos usar o `please` no lugar do `sudo`:

```
please apt update
```

**Atalhos do Git**

Fazer `push` para a branch com o mesmo nome:

```
push
```

É o mesmo que fazer `git push origin main`, estando na branch `main`, ou `git push origin dev`, estando na branch `dev`.

Dá pra fazer `pull` também, seguindo a mesma ideia:

```
pull
```

**Clonar repositórios de alunos para testes**

Como alguns alunos podem ter repositórios com o mesmo nome, eu clono sempre em um diretório que conterá `<nome-do-aluno>--<nome-do-repo>`. 
Para facilitar o processo, meu ZSH está configurado com o comando:

```
clone <endereco-ssh-do-repositorio-git>
```

Esse comando irá clonar o projeto em um diretório com o padrão informado acima, e já irá acessar o diretório (`cd`).

**Deixar saída de áudio mono**

Alguns áudios / vídeos só tem áudio em um canal. Então eu deixo esse comando fácil para deixar a saída do fone mono:

Para habilitar:

```
mono on
```

Para desabilitar:

```
mono off
```

**Converter vídeos .mp4 para funcionar no DaVnici Resolve**

Por algum motivo o DaVinci Resolve não suporta vídeos em `.mp4` e `.mkv`, nem áudios em `.mp3`. (pelo menos no Linux). 
Por isso é preciso converter esses arquivos antes de usar no Resolve:

```
toresolve <caminho-do(s)-arquivo(s)>
```

Para converter todos os arquivos de um diretório:

```
toresolve *
```

Para converter um único arquivo:

```
toresolve file.mp4
toresolve file.mkv
toresolve file.mp3
```

Serão criados diretórios `mov` e `wav` com os respectivos arquivos convertidos.

Se algum formato de arquivo não suportado estiver no diretório, ele será ignorado e uma mensagem de erro será exibida.

**Fix para vídeos corrompidos**

Alguns vídeos podem ficar corrompidos com a conversão para o Resolve, e acabam não abrindo. Alguns casos são solucionáveis com o comando:

```
fixvideo <caminho-do-video>
```

**Deletar branches já utilizadas**

Esse comando não deleta somente as branches `main`, `dev` e `staging`. Qualquer outra será deletada:

```
delete-branches
```

Para alterar as branches que ele não deve deletar, tem que alterar a função que gera o comando.
