#!/bin/bash
DEINPATH=~/.vim/dein

mkdir -p $DEINTPATH
cd $DEINPATH
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh $DEINPATH
#vim -c "call dein#install()" -c "call dein#update()" -c q

