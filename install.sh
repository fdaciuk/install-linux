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
  vim-gnome \
  keepassx \
  python-dbus \
  autojump \
  meld \
  vlc browser-plugin-vlc \
  git git-core \
  playonlinux

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
ok "Autojump"
ok "Meld"
ok "VLC"
ok "Git"
ok "PlayOnLinux"

if has_not pip; then
  sudo apt-get install python-pip python-dev build-essential
  sudo pip install --upgrade pip 
  sudo pip install --upgrade virtualenv
fi
ok "pip"

if has_not google-chrome-stable; then
  wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg --force-depends -i chrome.deb
  sudo apt-get install -fy
  rm chrome.deb
fi
ok "Chrome"

if has_not docker; then
  sudo apt-get install apt-transport-https ca-certificates linux-image-extra-$(uname -r) -y
  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  sudo sh -c "echo 'deb https://apt.dockerproject.org/repo ubuntu-$(lsb_release -sc) main' | cat > /etc/apt/sources.list.d/docker.list"
  sudo apt-get update
  sudo apt-get purge lxc-docker
  sudo apt-get install docker-engine -y
  sudo service docker start
  sudo groupadd docker
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
  curl -#So stremio.tar.gz http://dl.strem.io/Stremio3.5.7.linux.tar.gz
  sudo mkdir -p /opt/stremio
  sudo tar -xvzf stremio.tar.gz -C /opt/stremio
  curl -SO# http://www.strem.io/3.0/stremio-white-small.png
  sudo mv stremio-white-small.png /opt/stremio/
  curl -SO# https://gist.githubusercontent.com/claudiosmweb/797b502bc095dabee606/raw/52ad06b73d90a4ef389a384fbc815066c89798eb/stremio.desktop
  sudo mv stremio.desktop /usr/share/applications/
  rm stremio.tar.gz
fi
ok "Strem.io"

if has_not simplescreenrecorder; then
  sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder -y
  sudo apt-get update
  sudo apt-get install simplescreenrecorder -y
  # if you want to record 32-bit OpenGL applications on a 64-bit system:
  sudo apt-get install simplescreenrecorder-lib:i386 -y
fi
ok "Simple Screen Recorder"

if ! [[ -d "$HOME/.nvm" ]]; then
  NODE_VERSION=4
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
  source ~/.bashrc
  nvm install $NODE_VERSION
  nvm use $NODE_VERSION
  nvm alias default $NODE_VERSION
fi
ok "NVM"

npm i -g nodemon hmh-cli clima
ok "NodeJS global modules"

if has_not apache2; then
  sudo apt-get install -y apache2
  
  # Setup vhosts
  curl -sS -O https://gist.githubusercontent.com/claudiosmweb/ab41b5e8693eea7c02b8/raw/392305085efa1347c26498a1a5027037ae9c73be/000-default.conf
  sudo rm /etc/apache2/sites-available/000-default.conf
  sudo mv 000-default.conf /etc/apache2/sites-available
  ok "Setup vhosts"
    
  # Enable rewrite
  sudo a2enmod rewrite
  ok "Enable Apache rewrite"
    
  # Restart Apache2
  sudo service apache2 restart
  ok "Restart Apache"
  
  sudo chown -R $USER:$USER /var/www
  ln -s /var/www ~/code
fi
ok "Apache"

if has_not mysql; then
  sudo apt-get install -y mysql-server
fi
ok "MySQL"

if has_not php; then
  sudo apt-get install -y php-pear \
    php5-cli \
    php5-curl \
    php5-dev \
    php5-gd \
    php5-imagick \
    php5-imap \
    php5-mcrypt \
    php5-pspell \
    php5-tidy \
    php5-xmlrpc \
    php5-mysql \
    libapache2-mod-php5
fi
ok "PHP"

if ! [[ -d "/etc/phpmyadmin" ]]; then
  sudo apt-get install -y phpmyadmin
  sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-enabled/phpmyadmin.conf
fi
ok "PHPMyAdmin"
  
if has_not wp; then
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  sudo mv wp-cli.phar /usr/local/bin/wp
fi
ok "WP-CLI"

if has_not composer; then
  curl -sS https://getcomposer.org/installer | php
  sudo mv composer.phar /usr/local/bin/composer
fi
ok "Composer"

if has_not redis-server; then
  sudo apt-get install -y build-essential tcl8.5
  wget http://download.redis.io/redis-stable.tar.gz
  tar xvzf redis-stable.tar.gz
  cd redis-stable
  sudo make
  sudo make install
  cd utils
  sudo printf '\n\n\n\n\n\n' | sudo ./install_server.sh
  cd ../..
  rm -rf redis-stable*
fi
ok "Redis Server"
ok "PHP for WordPress"

if ! [[ -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
ok "OH My ZSH"

if has_not heroku; then
  wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi
ok "Heroku Toolbelt"

if has_not mongod; then
  sudo bash -c "$(wget -O - https://raw.githubusercontent.com/fdaciuk/install-linux/master/mongo-ubuntu.sh)"
fi
ok "Mongo DB"

sudo pip install wakatime
ok "Wakatime CLI (https://github.com/wbinglee/zsh-wakatime)"

# Clean up
sudo apt-get autoclean -y
sudo apt-get autoremove -y

ok "Installation finished!"
