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

install_asdf() {
  rm -rf ~/.asdf
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

  if ! grep -q "asdf-vm" ~/.bashrc; then
    {
      echo -e "\n# asdf-vm"
      echo ". $HOME/.asdf/asdf.sh"
      echo ". $HOME/.asdf/completions/asdf.bash"
    } >> ~/.bashrc
  fi

  source "$HOME/.asdf/asdf.sh"
  source "$HOME/.asdf/completions/asdf.bash"
}

need_install() {
  if which "$1" > /dev/null; then
    echo "Already installed $1"
    return 2
  else
    echo "Installing $1..."
    return 0
  fi
}

check_and_install_requirements() {
  echo "This script needs whiptail, git, asdf, curl and cmake to work. So, these will be installed."
  echo "Checking requirements..."
  sudo apt-get update

  if need_install whiptail; then
    sudo apt-get -y install whiptail
  fi

  if need_install git; then
    sudo apt-get -y install git
  fi

  if need_install asdf; then
    install_asdf
  fi

  if need_install curl; then
    sudo apt-get -y install curl
  fi
}

install_zsh() {
  if skip zsh; then
    echo "zsh already installed"
    return
  fi

  sudo apt update && sudo apt install -y zsh

  rm -rf ~/.oh-my-zsh ~/.zshrc ~/.fzf ~/.p10k.zsh
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
  wget -O ~/.zshrc https://raw.githubusercontent.com/grego1201/dotfiles/master/config/.zshrc

  chsh -s "$(which zsh)"
}

install_tmux() {
  if skip tmux; then
    echo "tmux already installed"
    return
  fi

  sudo apt update && sudo apt install -y xclip
  sudo apt install -y tmux
  wget -O ~/.tmux.conf https://raw.githubusercontent.com/grego1201/dotfiles/master/config/.tmux.conf
}

install_nodejs() {
  sudo apt-get update
  # https://github.com/asdf-vm/asdf-nodejs#requirements
  sudo apt-get -y install dirmngr gpg
  asdf plugin-add nodejs
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf install nodejs 14.17.0
  asdf global nodejs 14.17.0
}

install_neovim() {
  if skip neovim; then
    echo "Neovim already installed"
    return
  fi

  install_nodejs

  rm -rf ~/.config/nvim

  sudo apt install -y neovim
  sudo apt install -y nodejs
  sudo apt-get -y install silversearcher-ag xclip

  mkdir -p ~/.config/nvim/_temp ~/.config/nvim/_backup
  wget -O ~/.config/nvim/init.vim https://raw.githubusercontent.com/grego1201/dotfiles/master/config/nvim/init.vim
  wget -O ~/.config/nvim/coc-settings.json https://raw.githubusercontent.com/grego1201/dotfiles/master/config/nvim/coc-settings.json
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  nvim +PlugInstall +qa
  nvim +PlugUpdate +qa
}

check_and_install_requirements

install_dependencies
install_zsh
install_tmux
install_neovim

echo "Everything installed"
