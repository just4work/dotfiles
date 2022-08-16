#!/usr/bin/env bash

sudo apt-get update

# Essentials
sudo apt install -y \
    apache2-utils \
    apt-transport-https \
    autoconf \
    black \
    build-essential \
    ca-certificates \
    clangd-12 \
    cmake \
    curl \
    doxygen \
    gcc make \
    gdb \
    git \
    gnupg \
    htop \
    jq \ 
    libjansson-dev \
    libreadline6-dev \
    libseccomp-dev \
    libxml2-dev \
    libyaml-dev \
    luajit \
    nodejs \
    openjdk-8-jre-headless \
    pkg-config \
    python3 \
    python3-dev \
    python3-pip \
    shellcheck \
    silversearcher-ag \
    software-properties-common \ 
    tmux \
    unzip
    
# python virtualenv
python3 -m pip install virtualenv  

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


echo "installing homebrew"

# workaround to install bat over ripgrep
#sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep

# pipe <enter> key 
echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [ $? -eq 0 ]; then
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
    /home/linuxbrew/.linuxbrew/bin/brew shellenv
    
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
    brew install neovim
    brew install universal-ctags
    brew install duf 
    brew install broot
    brew install fd
    brew install dog
    brew install imagemagick

    # 
    mkdir -p ~/.docker/cli-plugins 
    ln -sfn /home/linuxbrew/.linuxbrew/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose


    # Android stuff
    brew install dex2jar
    brew install apktool

    # Setup neovim
    mkdir -p $HOME/.config/nvim/
    mkdir -p $HOME/.config/nvim/parser

    cp -r nvim/* $HOME/.config/nvim/
    nvim --headless +PackerInstall +qa
    nvim --headless +PackerCompile +qa
    nvim --headless -c 'CocInstall coc-clangd coc-pyright coc-tsserver coc-json coc-html coc-css coc-snippets' -c 'qall'

    # Dap plugins for neovim 
    # https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Javascript
    mkdir -p $HOME/.local/share/nvim
    git clone https://github.com/microsoft/vscode-node-debug2.git $HOME/.local/share/nvim/vscode-node-debug2
    git clone https://github.com/microsoft/vscode-chrome-debug.git $HOME/.local/share/nvim/vscode-chrome-debug

    echo "Installing vscode-node-debug2"
    cd $HOME/.local/share/nvim/vscode-node-debug2 
    npm install && npm run build
    cd -

    echo "Installing vscode-chrome-debug"
    cd $HOME/.local/share/nvim/vscode-chrome-debug
    npm install && npm run build
    cd -

    echo "download nerdfonts from 'https://www.nerdfonts.com/font-downloads'"
    echo "for WSL - Right click top left window on wsl and select default fonts"
fi


echo "Set up user group for docker - sudo usermod -aG docker ${USER}"

