#!/bin/bash
set -eo pipefail

not() {
  ! [[ -x "$(command -v "$1")" ]] ;
}

ok() {
  echo "→ "$1" OK"
}

sudo apt-get update 
sudo apt-get autoremove -y
sudo apt-get autoclean -y
ok "System updated!"

if not curl; then
  sudo apt-get install curl
fi
ok "Curl"

if not vim; then
  sudo apt-get install vim -y
fi
ok "Vim"

if not git; then
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt-get update
  sudo apt-get install git -y
fi
ok "Git"

if not atom; then
  sudo add-apt-repository -y ppa:webupd8team/atom
  sudo apt-get update
  sudo apt-get install atom -y
fi
ok "Atom"

if not google-chrome-stable; then
  wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg --force-depends -i chrome.deb
  rm chrome.deb
  sudo apt-get install -fy
fi
ok "Chrome"

if not docker; then
  wget -qO- https://get.docker.com/ | sh
  sudo usermod -aG docker $(whoami)
fi
ok "Docker"

if not keepassx; then
  sudo add-apt-repository -y ppa:keepassx/ppa
  sudo apt-get update
  sudo apt-get install keepassx -y
fi
ok "KeePassX"

if not dropbox; then
  bash -c "$(https://raw.githubusercontent.com/fdaciuk/elementary-dropbox/master/install.sh)"
fi
ok "Dropbox"
