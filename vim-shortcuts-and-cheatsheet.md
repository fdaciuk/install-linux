# Vim atalhos e comandos úteis

- [Meus dotfiles](https://github.com/fdaciuk/dotfiles)
- [Minhas configurações atuais](https://github.com/fdaciuk/install-linux/blob/master/pop-os.md)

---

- Alias `vim` e `vi` configurados para abrir o `nvim` (NeoVim);
- Tecla `leader` é a vírgula;

**Carregar arquivo de configuração do Neovim (Edit Vim)**

```
<leader>ev
```

**Dar reload no arquivo de configuração (Source Vim)**

```
<leader>sv
```

**Fern**

- Abrir o vim já com o Fern em drawer mode: `vim "+Fern . -drawer"`
- `ctrl + w`: navega entre os splits

**Abrir terminal dentro do Vim**

- `<leader>t` - abre o terminal em split mode, abaixo do buffer direito
- `<leader>vt` - abre o terminal em split mode vertical, à direita do buffer direito
- `ctrl + \ n`: muda do modo Terminal para o modo Normal

**Navegação**

- `Ctrl + u`: Navega com rolagem para cima
- `Ctrl + d`: Navega com rolagem para baixo
- `Ctrl + y`: Navega para cima sem mover o cursor
- `Ctrl + e`: Navega para baixo sem mover o cursor

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

**Mudar case das palavras (UPPERCASE e lowercase)**

```
lowercase: gu <movement>
uppercase: gU <movement>
toggle case: g~ <movement>
```

**Incrementar e decrementar números**

Coloque o cursor em cima do número e pressione:

- `Ctrl + a` = para incrementar
- `Ctrl + x` = para decrementar

**Navegar para onde estava (forward and backward)**

- `g;` = navega para última posição do cursor
- `g,` = navega para frente

**Navegar para o início / fim de um bloco (if, while, function, etc)**

- `[{` = navega para o início do bloco (inicia com "abre chaves" `{`)
- `]}` = navega para o fim do bloco (termina com "fecha chaves" `}`)
- `[(` = navega para o início do bloco (que inicia com "abre parênteses" `(`)
- `])` = navega para o fim do bloco (termina com "fecha parênteses" `)`)

**Navegar para uma linha e coluna específicas**

```
:call cursor($LINE,$COLUMN)
```

Exemplo: Quero ir para a linha 10, coluna 12:

```
:call cursor(10,12)
```

**Navegação entre imports (CoC)**

Com o cursor posicionado em cima da variável ou do caminho do `import`, use:

- `gd` = coc-definition
- `gy` = coc-type-definition
- `gr` = coc-references

Fonte: [https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim](https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim)

**Buscar arquivos com fzf - Fuzzy Finder (estilo Sublime Text)**

```
Ctrl + p
```

**Buscar arquivos com fzf, baseado na árvore do git**

```
Shift + Meta(Alt) + P
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


**Zoom in (para usar com o Fern drawer)**
Dá zoom no buffer fazendo ele ocupar toda a área vertical (sem alterar a área do Fern em drawer mode)

```
zoom
```

**Zoom out ([z]oom [n]ot [i]n)**
> Não usei `zo` aqui pois conflita com o atalho de folding.
```
zni
```

**Indentação de várias linhas à partir da atual (onde o cursor está)**

- `44>>`: indenta 44 linhas
- `10<<`: volta a indentação de 10 linhas
- `>at`: Indenta tags HTML (ou JSX) (`a`: _around_, `t`: _tag_)
- `>i{`: Indenta dentro (`i` de _inside_) das chaves. O cursor deve estar dentro das chaves.

**Exemplos de indentação:**

Função de exemplo em JavaScript:

```js
function sum () {
  const a = 1
  const b = 2
  return a + b
}
```

Colocando o cursor em qualquer linha da função, e pressionando `>i{`, todo o conteúdo dentro das chaves será indentado.
Esse mesmo atalho pode ser usado com qualquer par de chaves, colchetes ou parênteses.

Para indentar **inclusive** a função, só usar o `a` (_around_) ao invés do `i` (_inside_).

**Observação importante:** O `i` e `at` funcionam também para outros comandos que esperam movimentos:
- `c`, que aguarda um movimento para deletar e abrir para edição;
- `d`, que aguarda um movimento para deletar;
- `v`, que aguarda um  movimento para selecionar no modo visual;
- etc.

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

**Editar HTML / JSX**

- `cit`: _change inside tag_: deleta e abre para edição o conteúdo de uma tag
- `cstt`: atualiza o nome da tag. Esse comando tem algumas variações:
  - Edite a tag para `<div` para substituir somente o nome da tag por `div`, mantendo seus atributos;
  - Edite a tag para `<div>`, para substituir o nome da tag por `div`, removendo os atributos;
  - Edite a tag para `<div id="minha-div"` para substituir o nome da tag por `div`, e adicionar o atributo `id`, mantendo seus outros atributos;
  - Edite a tag para `<div id="minha-div">` para substituir o nome da tag por `div`, e adicionar apenas o atributo `id`, removendo todos os outros.

Outros atalhos podem ser encontrados na documentação do [vim-surround](https://github.com/tpope/vim-surround).

#### Folding

Sabe aqueles editores que tem um botão de "-" ao lado da linha onde começa uma função ou tag HTML (ou JSX)? E quando você clica, todo o código dentro dessa função é "compactado", ou "fechado", mostrando somente as linhas antes e depois desse código? Isso se chama **folding!**. E dá pra fazer isso no Vim :D

**Folding em tags HTML ou JSX**

1. Posicione o cursor a linha que inicia a tag onde você quer fazer o fold;
2. Execute o comando `zaf`. Isso vai criar um "fold" para aquela tag, e vai trazer fechado.
3. Para abrir, pode usar `za` (toggle fold) ou `zo` (open fold).
4. Para cada novo fold, é preciso usar o `zaf`, senão, ao usar os comandos para abrir / fechar, esses serão aplicados
sempre no último fold criado. Após ter criado um "fold", sempre que quiser abrir / fechar algum em específico, é só
posicionar o cursor na linha onde inicia,e pressionar `zc` (close fold) ou `za`.

**Folding em funções ou tags JSX**

1. Selecione as linhas da função que você quer fazer o fold, e crie o fold com `zf` (em alguns casos, será necessário usar o `zfat` ou `zfit`). Depois é só usar os comandos acima para abrir / fechar o fold conforme a necessidade :)

**Dica:** Para selecionar todas as linhas de uma função automaticamente (ou de uma tag no JSX), coloque o cursor em cima do nome da função (ou da tag de abertura) habilite o modo visual (`v`) e então pressione `%`. O `%` navega para o bracket de fechamento da função, ou para a tag de fechamento no JSX. Após fazer isso, só usar o `zf` para criar o folding =)

**Fechar todos os foldings**

Para fechar todos os foldings criados, só usar `zM`.

Referências:
- https://www.linux.com/training-tutorials/vim-tips-folding-fun/

#### Copiar / colar (registro)

Quando copiamos algo com `y` no vim, o conteúdo copiado vai para um registro. Se você selecionar um texto, e colar o que foi copiado, com `p`, a próxima vez que você tentar colar, o valor que vai ser colado foi o último valor que foi substituído, não o valor copiado inicialmente com `y`.

Para colar sempre o valor que foi copiado, ao invés de usar apenas `p`, é preciso usar entradas no registro, colando com `"0p`. Isso vai colar o último valor do registro que foi copiado.

É possível copiar também para um registro específico: ao invés de usar `y` para copiar, use `"ay`. Dessa forma, o valor será copiado (`y`) para o registro `a`.
Para colar à partir desse registro, só usar `"ap`. O `a` pode ser qualquer caractere.

Isso é legal porque é possível várias coisas de uma só vez, e depois só ir colando conforme a necessidade, ao invés de copiar uma coisa, colar ela, e então copiar outra coisa para colar :)

Referências: 
- https://vim.fandom.com/wiki/Copy,_cut_and_paste

---

**Formatar JSON (beutify / uglify)**

Instale a dependência `jq` no seu sistema operacional: 
https://stedolan.github.io/jq/

Após isso, podemos usar os comandos básicos no Neovim:

- `%!jq .` - Beautify: pegar um JSON sem formatação e formata de forma que facilite a visualização
- `%!jq -c .` - Uglify: pega um JSON formatado e coloca tudo em uma linha só

---
