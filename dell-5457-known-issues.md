# Problemas conhecidos

## Instalação passo-a-passo do Ubuntu Gnome 16.04

Entrar na BIOS, e resetar as configurações para configurações de fábrica (Factory settings);

Dar boot via pendrive e instalar normalmente, com o cabo de rede plugado, já que o wifi nao será reconhecido ainda;

Quando chegar na hora de selecionar as partições, não remover as que já existem. Só altere a partição onde está o Ubuntu 14.04, deixando o espaço que você precisar;

Deixe o grub no `/dev/sda`;

Após a instalação, o boot deverá carregar normalmente.

### Instalação da placa wireless:

**Modelo:**

```
description: Wireless interface
product: QCA6174 802.11ac Wireless Network Adapter
vendor: Qualcomm Atheros
```

Execute o comando abaixo:

```console
bash -c "$(wget -O - https://raw.githubusercontent.com/fdaciuk/install-linux/master/qualcomm-atheros-wireless.sh)"
```

reinicie o notebook e deve funcionar!

> fonte: https://www.vivaolinux.com.br/topico/Rede-Wireless/Alguem-me-ajude-wifi-ubuntu-1604?pagina=2

---

### Sobre o driver de video

Não instale  o que está em Drivers adicionais. A tela fica escura e não carrega o sistema coretamente. Para instalar o driver de video, siga os passos abaixo:

- Remova o login automatico (se estiver habilitado);

- Troque o GDM pelo Lightdm:

```console
sudo apt-get install lightdm
```

Selecione o `lightdm` como padrão.

Reinicie e veja se o está fazendo login pelo lightdm.

Abra um novo TTY (`Ctrl + Alt + F1`) e execute:

```console
sudo apt-get purge nvidia-*
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get install nvidia-364
sudo reboot
```

Se tudo correu bem, o driver estará instalado corretamente!

Para atualizar, execute no TTY:

```console
sudo apt-get install nvidia-367
```

ou escoha a versão mais recente e reinicie!
