#!/bin/bash

skip() {
  if dpkg-query -l | grep "$1" -c > 0; then
    return 0
  else
    return 1
  fi
}

install_dependencies() {
  sudo apt update && sudo apt install -y curl git
}

install_zsh() {
  if skip zsh; then
    echo "zsh already installed"
    return
  fi

  sudo apt install -y zsh
  wget -O ~/.zshrc https://raw.githubusercontent.com/grego1201/dotfiles/master/zsh/.zshrc
}

install_tmux() {
  if skip tmux; then
    echo "tmux already installed"
    return
  fi

  sudo apt update && sudo apt install -y xclip
  sudo apt install -y tmux
  wget -O ~/.tmux.conf https://raw.githubusercontent.com/grego1201/dotfiles/master/tmux/.tmux.conf
}

install_neovim() {
  if skip neovim; then
    echo "Neovim already installed"
    return
  fi

  sudo apt install -y neovim
  sudo apt install -y nodejs
  sudo apt-get -y install silversearcher-ag xclip

  mkdir -p ~/.config/nvim/_temp ~/.config/nvim/_backup
  wget -O ~/.config/nvim/init.vim https://raw.githubusercontent.com/grego1201/dotfiles/master/nvim/init.vim
  wget -O ~/.config/nvim/coc-settings.json https://raw.githubusercontent.com/grego1201/dotfiles/master/nvim/coc-settings.json
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  nvim +PlugInstall +qa
  nvim +PlugUpdate +qa
}

install_zsh
install_tmux
install_neovim

echo "Everything installed"
