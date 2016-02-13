#!/bin/bash
set -eo pipefail

has() {
  [[ -x "$(command -v "$1")" ]];
}

has_not() {
  ! has "$1" ;
}

ok() {
  echo "→ "$1" OK"
}

update() {
  sudo pacman -Syu
}

install() {
  sudo pacman -S --noconfirm "$1"
}

remove() {
  sudo pacman -R "$1"
}

removePackageAndConfigs() {
  sudo pacman -Rn "$1"
}

removePackageAndAllDependencies() {
  sudo pacman -Rsc "$1"
}

update

if has_not pygtk; then
  install pygtk python2 cairo
fi
ok "Python"

if has_not xsel; then
  install xsel
fi
ok "XSel"

if has_not htop; then
  install htop
fi
ok "Htop"

if has_not s3cmd; then
  install s3cmd
fi
ok "S3CMD"

if has_not terminator; then
  install terminator
fi
ok "Terminator"

if has_not keepassx2; then
  install keepassx2
fi
ok "KeePassX2"

if has_not vlc; then
  install vlc
fi
ok "VLC"

if has_not docker; then
  install docker
fi
ok "Docker"

if has_not meld; then
  install meld
fi
ok "Meld"

if has_not autojump; then
  install autojump
  source /etc/profile.d/autojump.zsh
fi
ok "Autojump"

if has_not simplescreenrecorder; then
  install simplescreenrecorder
fi
ok "Simple Screen Recorder"

if has_not node; then
  install nodejs
fi
ok "NodeJS"

if has_not npm; then
  install npm
fi
ok "NPM"

if has_not apache; then
  install apache
fi
ok "Apache2"

if ! [[ -d "$HOME/.nvm" ]]; then
  NODE_VERSION=5
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
  source ~/.zshrc
  nvm install $NODE_VERSION
  nvm use $NODE_VERSION
  nvm alias default $NODE_VERSION
fi
ok "NVM"

if has_not dropbox; then
  curl -O -J -L https://www.dropbox.com/download?dl=packages/nautilus-dropbox-1.4.0.tar.bz2
  tar xjf ./nautilus-dropbox-1.4.0.tar.bz2
  cd nautilus-dropbox-1.4.0
  ./configure
  make
  make install
fi

sudo npm i -g nodemon pnpm mocha babel-cli
ok "Node global modules"

ok "Installation finished!"
