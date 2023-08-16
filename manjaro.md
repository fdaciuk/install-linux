# Possíveis problemas com Manjaro

## Ambiente gráfico não sobe (conflito de drivers proprietários da nVidia)

Quando o GDM não estiver subindo, faça o seguinte:
- Reinicie o PC;
- Na tela do Grub, pressione "e";
- Na linha "linux", adicione um "3" no final da linha (com um espaço antes);
- Pressione Ctrl + X para salvar e bootar em modo texto.

Após logar, remova os drivers da Nvidia:

```console
sudo mhwd -r pci video-nvidia
```

Isso vai remover o driver da nvidia. Após isso, faça o reboot.

Quando logar novamente, já vai entrar em modo gráfico, mas com o driver padrão.

**Instale novamente o driver da Nvidia**

Para instalar o driver da nvidia, é só usar o comando:

```console
sudo pacman -S linux518-nvidia
```

O 518 é o número do kernel. É importante ficar atento porque, ao instalar o driver, o kernel com esse número será instalado junto.
Veja se a versão do kernel é estável antes de instalar. Prefira sempre usar versões LTS.

Após a instalação, é só reiniciar o PC novamente que tudo vai estar funcionando \o/

## Downgrade de pacotes

Com o lançamento da v254 do systemd, o Gnome começou a dar crash quando tentávamos reiniciar o GDM usando "Alt + F2 + r". Com a v253 o problema não acontece.
Para fazer o downgrade do systemd (ou qualquer outro pacote) é só seguir as instruções [desse link](https://wiki.manjaro.org/index.php/Downgrading_packages).

### Issues relacionadas com o problema do systemd 254 para acompanhar

- https://gitlab.gnome.org/GNOME/gnome-shell/-/issues/6899
- https://bbs.archlinux.org/viewtopic.php?id=287955

Para verificar a versão do `systemd`, executar `systemctl --version`.
