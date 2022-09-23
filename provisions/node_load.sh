function installNodeJs() {
  curl -sL https://deb.nodesource.com/setup_14.x | bash -

  sudo apt-get install -y nodejs

  npm install npm@latest -g
  npm install -g create-react-app

  sudo apt install build-essential checkinstall
  sudo apt install libssl-dev

  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

  source /etc/profile

  echo "Смотрим доступные версии: "

  nvm ls-remote

  nvm install 16.17.1
  nvm use 16.17.1
}

installNodeJs