#!/bin/bash
set -eo pipefail

has() {
  [[ -x "$(command -v "$1")" ]] ;
}

has_not() {
  ! has "$1" ;
}

ok() {
  echo "→ "$1" OK"
}

sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo apt-get update
sudo apt-get install -y \
  ubuntu-restricted-extras \
  xsel \
  smbclient \
  htop \
  openssh-server \
  s3cmd \
  zsh \
  terminator \
  curl \
  vim \
  keepassx \

ok "System updated!"
ok "XSel"
ok "SMB Client"
ok "HTop"
ok "OpenSSH Server"
ok "S3 CMD"
ok "ZSH"
ok "Terminator"
ok "Curl"
ok "Vim"
ok "KeePassX"

if has_not git; then
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt-get update
  sudo apt-get install git -y
fi
ok "Git"

if has_not atom; then
  sudo add-apt-repository -y ppa:webupd8team/atom
  sudo apt-get update
  sudo apt-get install atom -y
fi
ok "Atom"

if has_not google-chrome-stable; then
  wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg --force-depends -i chrome.deb
  rm chrome.deb
  sudo apt-get install -fy
fi
ok "Chrome"

if has_not docker; then
  wget -qO- https://get.docker.com/ | sh
  sudo usermod -aG docker $(whoami)
fi
ok "Docker"

if has nautilus && has_not dropbox; then
  sudo apt-get install nautilus-dropbox -y
fi
ok "Dropbox"
