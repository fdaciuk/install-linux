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
ok "System updated!"

if has_not curl; then
  sudo apt-get install curl
fi
ok "Curl"

if has_not vim; then
  sudo apt-get install vim -y
fi
ok "Vim"

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

if has_not keepassx; then
  sudo apt-get install keepassx -y
fi
ok "KeePassX"

if has nautilus && has_not dropbox; then
  sudo apt-get install nautilus-dropbox -y
fi
ok "Dropbox"
