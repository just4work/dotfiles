#!/usr/bin/env bash

sudo apt-get update

# Essentials
sudo apt install -y \
    autoconf \
    pkg-config \
    build-essential \
    curl \
    cmake \
    doxygen \
    gdb \
    git \
    gnupg \
    htop \
    nodejs \
    python3 \
    python3-pip \
    shellcheck \
    silversearcher-ag \
    tmux \
    libreadline6-dev \
    python3-dev \
    gcc make \
    libseccomp-dev \
    libjansson-dev \
    libyaml-dev \
    libxml2-dev \
    neovim \
    luajit \
    ripgrep \
    unzip \
    apache2-utils \
    openjdk-8-jre-headless \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    universal-ctags
    
# python virtualenv
pip3 install virtualenv autopep8

# node version manager
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install nodes version 16 & 18. Use 16 by default
nvm install 16
nvm install 18
nvm alias default 16

## tmux
git clone "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"
cp -vf ./dotfiles/\.* "$HOME/"
cp -vf ./tmux_workspace/* "$HOME/.tmux/"
cp -vf "tmux.terminfo" "$HOME/tmux.terminfo"
sudo tic -x $HOME/tmux.terminfo

# Make bin directory
mkdir -p $HOME/bin
cp -vf ./bin/* "$HOME/bin/"

chmod +x $HOME/bin/*

# less settings with highlighting
/bin/cat exports/less_settings >> ~/.bashrc
/bin/cat exports/bash_prompt >> ~/.bashrc

# Setup neovim
mkdir -p $HOME/.config/nvim/
mkdir -p $HOME/.config/nvim/parser

cp -r nvim/* $HOME/.config/nvim/
nvim -c 'qa!'
nvim -c ':CocInstall coc-pyright coc-tsserver coc-json coc-html coc-css' -c 'qa!'
echo "download nerdfonrts from 'https://www.nerdfonts.com/font-downloads'"
echo "for WSL - Right click top left window on wsl and select default fonts"

echo "installing homebrew"

# workaround to install bat over ripgrep
#sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [ $? -eq 0 ]; then
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
    
    brew install docker
    brew install docker-compose
    brew install httpstat
    brew install dust 
    brew install gping
    brew install broot
    brew install cheat
    brew install dog
    brew install bat
    brew install ripgrep
    brew install git-delta

    # Android stuff
    brew install dex2jar
    brew install apktool
fi


echo "Set up user group for docker - sudo usermod -aG docker ${USER}"

