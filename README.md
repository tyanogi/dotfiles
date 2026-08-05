# Prerequirements
## Software
- git
- curl
- zsh
- [mise](https://mise.jdx.dev/) (Required for macOS)

## Terminal fonts
Choose your favorite font in [NerdFont](https://www.nerdfonts.com/font-downloads)
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
# Setup environment and create symbolic links
make init
```

`make init` will:
- Create `local-env.zsh` for local environment settings.
- Create symbolic links for `.zshrc`, `.tmux.conf`, and other config files.

### Local Environment Settings (`local-env.zsh`)
`local-env.zsh` is used for machine-specific configurations (e.g., machine-specific PATH settings or environment variables).
This file is automatically loaded at the very beginning of `.zshrc`. It is ignored by git so you can define local settings without affecting the repository.

## Ubuntu
For a clean Ubuntu environment (e.g., Docker container).

Run these from inside the cloned `~/dotfiles` directory. They assume a normal user
with `sudo`; in a bare container that already runs as root, drop every `sudo` prefix.

```bash
# 1. Install required libraries
sudo apt-get update && sudo apt-get install -y \
  curl git sudo build-essential libevent-dev libncurses-dev bison pkg-config zsh locales

# 2. Install mise
curl https://mise.jdx.dev/install.sh | sh

# 3. Activate mise for the current shell session
eval "$("$HOME/.local/bin/mise" activate bash)"
mise trust

# 4. Install tools via mise (reads .config/mise/mise.toml from this directory)
mise install --yes

# 5. Setup environment and create symbolic links
make init

# 6. Install Neovim plugins.
#    `+Lazy! install` returns while mason is still installing in the background,
#    so mason-managed tools need a second, synchronous pass.
mise exec neovim -- nvim --headless "+Lazy! install" +qall
mise exec neovim -- nvim --headless "+Lazy! load mason.nvim" \
  "+MasonInstall tree-sitter-cli shfmt stylua" +qa

# 7. Install tmux plugin manager and plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# 8. Persist the machine-local environment.
#    zsh does not read ~/.profile, so $HOME/.local/bin (mise) has to be added here,
#    and a bare `export LANG` would not survive the next login either.
sudo locale-gen en_US.UTF-8
cat >> local-env.zsh <<'EOF'
export PATH="$HOME/.local/bin:$PATH"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
EOF

# 9. Make zsh the login shell
sudo chsh -s "$(command -v zsh)" "$(whoami)"
```

`mise` will manage the following tools:
- Neovim: Hyperextensible Vim-based text editor
- fzf: General-purpose command-line fuzzy finder
- Sheldon: Fast, configurable, shell plugin manager
- Oh My Posh: Prompt theme engine for any shell
- tmux: Terminal multiplexer
- eza: A modern, maintained replacement for ls

# Use with Docker / Dev Containers
This repository provides custom Docker images on GHCR.

## Standard Dotfiles Image
A clean Ubuntu environment with these dotfiles pre-installed.
- [ghcr.io/tyanogi/dotfiles](https://github.com/tyanogi/dotfiles/pkgs/container/dotfiles)

```bash
docker run -it --rm ghcr.io/tyanogi/dotfiles:latest
```

## Containerlab Dev Environment
A specialized image based on `containerlab/devcontainer-dind`, optimized for network topology testing with VS Code Dev Containers.

- [ghcr.io/tyanogi/containerlab-dev](https://github.com/tyanogi/dotfiles/pkgs/container/containerlab-dev)
- Base Image: `ghcr.io/srl-labs/containerlab/devcontainer-dind:0.72.0`
- User: `vscode`
- Pre-configured alias: `clab` (with `CLAB_LABDIR_BASE=/var/tmp/clab`)

### Use in devcontainer.json
```json
{
    "image": "ghcr.io/tyanogi/containerlab-dev:latest",
    "remoteUser": "vscode",
    "customizations": {
        "vscode": {
            "settings": {
                "terminal.integrated.defaultProfile.linux": "zsh",
                "terminal.integrated.fontFamily": "MesloLGS NF, FiraCode Nerd Font, monospace"
            }
        }
    }
}
```