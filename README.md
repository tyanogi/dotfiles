## 実行方法
curl -L raw.github.com/tyanogi/dotfiles/master/install.sh | bash

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
