#!/bin/bash
source os.sh
DOTPATH=~/dotfiles

get_os

if [ $OS = 'ubuntu' ]; then
  echo $OS
  sudo apt update
  sudo apt install -y tmux zsh git
  # install neovim
  sudo apt install -y software-properties-common
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt update
  sudo apt install -y neovim

  sed -i 's/.*default-shell/#&/g' $DOTPATH/.tmux.conf
  #sed -i 's/set clipboard=autoselect/"&/g' $DOTPATH/vim/init/basic.vim 
  #sed 's/"set clipboard=unnamedplus/set clipboard=unnamedplus/g' $DOTPATH/vim/init/basic.vim
  chsh -s $(which zsh)
elif [ $OS = 'mac' ]; then
  echo $OS
  brew install tmux zsh git neovim
else
  echo $OS
fi
