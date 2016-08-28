# install linux

> Softwares to install on Linux with just one command

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
- Vim (Gnome)
- KeePassX
- VLC
- Git
- PlayOnLinux
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
- OH My ZSH
- Heroku Toolbelt
- MongoDB

> Enjoy it ;)

## Other softwares to install
- [Lightworks](https://www.lwks.com/) (video editor): http://downloads.lwks.com/lwks-12.6.0-amd64.deb
- [Avocode](https://avocode.com/)
- [SQLEctron](https://sqlectron.github.io/)
- [RoboMongo](https://robomongo.org/) (Mongo GUI)

## After Install

**Configure GIT:**

```console
git config --global user.email "your@email"
git config --global user.name "Your name"
```

**Generate SSH Keys (or copy, if you already have one):**

```sh
ssh-keygen -t rsa -b 4096 -C "your@email"

# Try
ssh -T git@github.com
ssh -T git@bitbucket.com
```

**Generate GPG Keys:**

- Follow this steps: https://help.github.com/articles/generating-a-new-gpg-key/
- Telling Git about your GPG Keys: https://help.github.com/articles/telling-git-about-your-gpg-key/

Then, just commit using `git commit -S` =)

## Install Top Icons (Gnome Shell)

https://github.com/phocean/TopIcons-plus

## Install fonts

**Consolas:**

fonte: http://ssup2.iptime.org/wiki/Ubuntu_Consolas_Font_Install

**Source Code PRO:**

```console
bash -c "$(wget -O - https://gist.githubusercontent.com/fdaciuk/8b3269a3d797ee723672/raw/c8344f9cd4f91a8ae69535c833253ae87ef86d5b/sourcecodepro.sh)"
```

## Useful commands

**Auto mount a partition:**

Add entry on your `/etc/fstab` file:

```fstab
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
/dev/sdaX       /media/storage  ext4    defaults        0       1
```

[**Relase idle memory**](http://www.vivaolinux.com.br/dica/Liberando-memoria-RAM-ociosa)

```console
sudo sysctl -w vm.drop_caches=3
```

**Clear swap**

```console
sudo swapoff -a
sudo swapon -a
```

**Removing dpkg package**

```console
sudo dpkg -r <package>
```

**Stop services from startup without remove**

```console
sudo update-rc.d -f <service> remove
```

**Check which services are running**

```console
service --status-all
```

## Clone an installation

After boot from a Live USB, run on terminal:

```
dd if=/dev/sdb3 of=/dev/sda3
```

Where `sdb3` is the origin, and `sda3` is the destination.

After that, run:

```
sudo mount /dev/sda3 /mnt 
```

Where sda3 contains the recently copied boot and root partitions.

```sh
sudo mount --bind /dev/ /mnt/dev/
sudo mount -t /proc none /mnt/proc
sudo chroot /mnt
# note this is `sda` not `sda3`
sudo grub-install /dev/sda 
sudo update-grub
exit
```

## License

[MIT](https://github.com/fdaciuk/licenses/blob/master/MIT-LICENSE.md) © Fernando Daciuk
