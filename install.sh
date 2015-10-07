not() {
  ! [ -x "$(command -v "$1")" ] ;
}

# Update system
sudo apt-get update
sudo apt-get autoremove -y
sudo apt-get autoclean -y
echo "→ System updated!"

# Vim
if not vim; then
  sudo apt-get install vim -y
fi
echo "→ Vim OK"

# Git
if not git; then
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt-get update
  sudo apt-get install git -y
fi
echo "→ Git OK"

# Atom
if not atom; then
  sudo add-apt-repository -y ppa:webupd8team/atom
  sudo apt-get update
  sudo apt-get install atom -y
fi

# Chrome
if not google-chrome-stable; then
  wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg --force-depends -i chrome.deb
  rm chrome.deb
  sudo apt-get install -fy
fi
echo "→ Chrome OK"

# Docker
if not docker; then
  wget -qO- https://get.docker.com/ | sh
  sudo usermod -aG docker $(whoami)
fi
echo "→ Docker OK"

# KeePassX
if not keepassx; then
  sudo add-apt-repository -y ppa:keepassx/ppa
  sudo apt-get update
  sudo apt-get install keepassx -y
fi
echo "→ KeePassX OK"
