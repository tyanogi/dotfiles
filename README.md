## 実行方法
1. dein-vimをインストールする
2. fira fontをインストールする
```
brew tap homebrew/cask-fonts
brew cask install font-fira-code
```
iterm2でfontをfiraに設定する
3. makeでホームディレクトリにシンボリックリンクを貼る</br>
```
make all
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
