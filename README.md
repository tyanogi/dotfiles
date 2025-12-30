# Prerequirements
## Software
- git
- curl
- zsh
- [mise](https://mise.jdx.dev/)

## Termianl fonts
Choose your favorite font in [NerfFont](https://www.nerdfonts.com/font-downloads)
- CaskaydiaCove: https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/CascadiaCode/Regular/CaskaydiaCoveNerdFont-Regular.ttf

# Installation
## Local Computer
Clone this repository just under your `$HOME`
```
git clone https://github.com/tyanogi/dotfiles.git
cd dotfiles
```

Install tools and setup environment
```
make install
make link
```

`mise` will manage the following tools:
- Neovim
- fzf
- Sheldon
- Oh My Posh
- tmux

# Use with Docker
[tyanogi/dotfiles](https://github.com/tyanogi/dotfiles/pkgs/container/dotfiles)
```
docker run -it --rm ghcr.io/tyanogi/dotfiles:latest
```