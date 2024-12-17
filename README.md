# Prerequirements
- git
- curl
- [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- zsh
- [oh-my-zsh](https://ohmyz.sh/#install)
- [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)

# Setup
## Install oh-my-zsh plugin
```
./oh-my-zsh-plugin-install.sh
```

## 
```
DOTPATH=~/dotfiles
ln -sf $DOTPATH/.zshrc ~/.zshrc
ln -sf $DOTPATH/.config/nvim ~/.config/nvim
```