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
  python-dbus

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
  sudo apt-get install -fy
  rm chrome.deb
fi
ok "Chrome"

if has_not docker; then
  wget -qO- https://get.docker.com/ | sh
  sudo usermod -aG docker $(id -un)
fi
ok "Docker"

if has nautilus && has_not dropbox; then
  sudo apt-get install nautilus-dropbox -y
fi
ok "Dropbox"

if has_not diffmerge; then
  wget -O diffmerge.deb http://download-us.sourcegear.com/DiffMerge/4.2.0/diffmerge_4.2.0.697.stable_amd64.deb
  sudo dpkg -i diffmerge.deb --ignore-depends
  sudo apt-get install -fy
  rm -rf diffmerge.deb
fi
ok "Diffmerge"

if has_not skype; then
  wget -O skype.deb http://download.skype.com/linux/skype-ubuntu-precise_4.3.0.37-1_i386.deb
  sudo dpkg -i skype.deb --ignore-depends
  sudo apt-get install -fy
  rm -rf skype.deb

  # Gnome Shell extension
  wget -O skype-extension.zip https://github.com/chrisss404/gnome-shell-ext-SkypeNotification/archive/master.zip
  unzip skype-extension.zip -d skype-extension
  cp -r skype-extension/gnome-shell-ext-SkypeNotification-master/SkypeNotification@chrisss404.gmail.com/ \
    ~/.local/share/gnome-shell/extensions
  rm -rf skype-extension*
fi
ok "Skype"

if ! [[ -d "/opt/stremio" ]]; then
  curl -#So stremio.tar.gz http://178.62.254.47/Stremio3.3.3.linux.tar.gz
  sudo mkdir -p /opt/stremio
  sudo tar -xvzf stremio.tar.gz -C /opt/stremio
  curl -SO# http://www.strem.io/3.0/stremio-white-small.png
  sudo mv stremio-white-small.png /opt/stremio/
  curl -SO# https://gist.githubusercontent.com/claudiosmweb/797b502bc095dabee606/raw/52ad06b73d90a4ef389a384fbc815066c89798eb/stremio.desktop
  sudo mv stremio.desktop /usr/share/applications/
  rm stremio.tar.gz
fi
ok "Strem.io"

if ! [[ -d "~/.nvm" ]]; then
  NODE_VERSION=4
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
  source ~/.bashrc
  nvm install $NODE_VERSION
  nvm use $NODE_VERSION
  nvm alias default $NODE_VERSION
fi
ok "NVM"

if has_not php; then
  # Apache 2
  sudo apt-get install -y apache2 \
  
  # MySQL
  mysql-server \
  
  # PHP
  php-pear php5-cli php5-curl php5-dev php5-gd php5-imagick php5-imap php5-mcrypt php5-pspell php5-tidy php5-xmlrpc php5-mysql libapache2-mod-php5 \
  
  # PHPMyAdmin
  phpmyadmin
  sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-enabled/phpmyadmin.conf
  
  # Setup vhosts
  curl -sS -O https://gist.githubusercontent.com/claudiosmweb/ab41b5e8693eea7c02b8/raw/392305085efa1347c26498a1a5027037ae9c73be/000-default.conf
  sudo rm /etc/apache2/sites-available/000-default.conf
  sudo mv 000-default.conf /etc/apache2/sites-available
  
  # Enable rewrite
  sudo a2enmod rewrite
  
  # Restart Apache2
  sudo service apache2 restart
  
  # WP-CLI
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  sudo mv wp-cli.phar /usr/local/bin/wp

  # Composer
  curl -sS https://getcomposer.org/installer | php
  sudo mv composer.phar /usr/local/bin/composer

  # Redis Server
  sudo apt-get install -y build-essential tcl8.5
  wget http://download.redis.io/redis-stable.tar.gz
  tar xvzf redis-stable.tar.gz
  cd redis-stable
  make
  make install
  cd utils
  printf '\n\n\n\n\n\n' | ./install_server.sh
fi
ok "PHP for WordPress"

# Clean up
sudo apt-get autoclean -y
sudo apt-get autoremove -y
