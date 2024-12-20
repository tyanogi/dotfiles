# Prerequirements
## Software
- git
- curl
- tmux
- zsh
- [oh-my-zsh](https://ohmyz.sh/#install)
- [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)

## Termianl fonts
Choose your favorite font in [NerfFont](https://www.nerdfonts.com/font-downloads)
- CaskaydiaCove: https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/CascadiaCode/Regular/CaskaydiaCoveNerdFont-Regular.ttf

# Installation
## Local Computer
Clone this repository just under your `$HOME`
```
git clone https://github.com/tyanogi/dotfiles.git
```
Install oh-my-zsh plugin
```
./oh-my-zsh-plugin-install.sh
```
Create symboric link
```
make link
```

# Use with Docker
[tyanogi/dotfiles](https://github.com/tyanogi/dotfiles/pkgs/container/dotfiles)
```
docker run -it --rm ghcr.io/tyanogi/dotfiles:latest
```