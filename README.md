## Setup
```
$ bash -c "$(curl -L raw.github.com/tyanogi/dotfiles/master/install.sh)"

# deinのinstall
$ vim
:call dein#install()
:call dein#update()
```

## vimrc(dein)
### 構造
```
vim  
|  
|--- init ------ base.vim  
|             |- color.vim  
|             |- mapping.vim  
|             |- plugins.vim  
|
|--- plugins --- plugins-nerdtree-git-plugin.vim
              |- plugins-open-browser.vim
              |- plugins-vimshell.vim
```
