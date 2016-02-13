# install-linux

> Softwares to install on Linux just with one command

## Usage

Just run:

**Ubuntu (Debian like):**

```console
bash -c "$(wget -O - https://raw.githubusercontent.com/fdaciuk/install-linux/master/install.sh)"
```

---

**Apricity (Arch Linux like):**

```console
bash -c "$(wget -O - https://raw.githubusercontent.com/fdaciuk/install-linux/master/apricity-install.sh)"
```

To install some softwares, you will need `yaourt`.

Edit your `/etc/pacman.conf`, adding this lines:

```
[archlinuxfr]
Server = http://repo.archlinux.fr/$arch
```

After that, update the system:

```console
sudo pacman -Sy
```

If `yaourt` is not installed, install it:

```console
sudo pacman -S yaourt
```

Then, use `yaourt` -S <package-name> to install any package ;)

---

## Softwares that will be installed:

- XSel
- SMB Client
- HTop
- OpenSSH Server
- S3 CMD
- ZSH
- Terminator
- Curl
- Vim
- KeePassX
- VLC
- Git
- Atom
- Chrome
- Docker
- Dropbox
- Diffmerge
- Skype
- Strem.io
- Simple Screen Recorder
- NVM
  - Nodemon
- Apache 2
- MySQL
- PHP
- PHPMyAdmin
- WP-CLI
- Composer
- Redis Server
- Flowblade (Video editor)

> Enjoy it ;)

## Useful commands

**Auto mount a partition:**

Add entry on your `/etc/fstab` file:

```fstab
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
/dev/sdaX       /media/storage  ext4    defaults        0       1
```

[**Relase idle memory**](http://www.vivaolinux.com.br/dica/Liberando-memoria-RAM-ociosa)

```sh
sudo sysctl -w vm.drop_caches=3
```

**Clear swap**

```sh
sudo swapoff -a
sudo swapon -a
```

**Removing dpkg package**

```sh
sudo dpkg -r <package>
```

## License

[MIT](https://github.com/fdaciuk/licenses/blob/master/MIT-LICENSE.md) © Fernando Daciuk
