#!/bin/bash
source os.sh
DOTPATH=~/dotfiles

get_os

if [ $OS = 'ubuntu' ]; then
  echo $OS
  sudo apt update
  sudo apt install -y vim-gtk tmux zsh git
  sed -i 's/.*default-shell/#&/g' $DOTPATH/.tmux.conf
  chsh -s which zsh
elif [ $OS = 'mac' ]; then
  echo $OS
else
  echo $OS
fi