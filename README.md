# Prerequirements
## Software
- git
- curl
- zsh
- [mise](https://mise.jdx.dev/) (Required for macOS)

## Termianl fonts
Choose your favorite font in [NerfFont](https://www.nerdfonts.com/font-downloads)
- CaskaydiaCove: https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/CascadiaCode/Regular/CaskaydiaCoveNerdFont-Regular.ttf

# Installation
Clone this repository just under your `$HOME`
```bash
git clone https://github.com/tyanogi/dotfiles.git
cd dotfiles
```

## macOS
Assume `mise` is already installed.

```bash
# Install tools and setup environment
make install
make link
```

## Ubuntu
For a clean Ubuntu environment (e.g., Docker container).

```bash
# 1. Install required libraries
apt-get update && apt-get install -y curl git sudo build-essential libevent-dev libncurses-dev bison pkg-config zsh

# 2. Install mise
curl https://mise.jdx.dev/install.sh | sh

# 3. Activate mise for the current shell session
eval "$(/root/.local/bin/mise activate bash)"
mise trust

# 4. Install tools via mise
mise install --yes

# 5. Create symbolic links
make link

# 6. Install tmux plugin manager and plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# 7. Setup UTF-8 locale
apt-get update && apt-get install -y locales
locale-gen en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

`mise` will manage the following tools:
- Neovim: Hyperextensible Vim-based text editor
- fzf: General-purpose command-line fuzzy finder
- Sheldon: Fast, configurable, shell plugin manager
- Oh My Posh: Prompt theme engine for any shell
- tmux: Terminal multiplexer
- eza: A modern, maintained replacement for ls

# Use with Docker
[tyanogi/dotfiles](https://github.com/tyanogi/dotfiles/pkgs/container/dotfiles)
```
docker run -it --rm ghcr.io/tyanogi/dotfiles:latest
```
