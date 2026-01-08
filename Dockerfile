FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
ENV FORCE_COLOR=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    zsh \
    tmux \
    sudo \
    fzf \
    ca-certificates \
    build-essential \
    locales \
    libevent-dev \
    libncurses-dev \
    bison \
    pkg-config

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

ARG USERNAME=dev
RUN useradd -m -s /bin/zsh ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Install mise (Version Manager)
RUN curl https://mise.jdx.dev/install.sh | sh
ENV PATH="/home/${USERNAME}/.local/bin:$PATH"

# Setup dotfiles early to get mise.toml
RUN git clone https://github.com/tyanogi/dotfiles.git ./dotfiles && \
    cd ./dotfiles && \
    make link && \
    touch local-env.zsh

# Install tools via mise (neovim, fzf, sheldon, oh-my-posh, tmux, eza, node)
# Note: node is needed for gemini-cli
RUN mise trust && \
    mise install --yes node@20 && \
    mise install --yes

# Install gemini-cli using the node installed by mise and update shims
RUN mise use --global node@20 && \
    mise exec node@20 -- npm install -g @google/gemini-cli && \
    mise reshim

# Setup Gemini CLI settings
RUN mkdir -p /home/${USERNAME}/.gemini && \
    echo '{"ide": {"hasSeenNudge": true, "enabled": true}, "security": {"auth": {"selectedType": "oauth-personal"}}, "general": {"previewFeatures": true}}' > /home/${USERNAME}/.gemini/settings.json

# Install Gemini CLI conductor extension
RUN echo "y" | mise exec node@20 -- gemini extensions install https://github.com/gemini-cli-extensions/conductor --auto-update

# Setup Neovim (AppImage is handled by mise now, but we need to ensure it's in path or use mise version)
# Based on mise.toml, mise handles neovim.

# Install Neovim plugins
RUN mise exec neovim -- nvim --headless "+Lazy! install" +qall

# Install tmux plugins
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
RUN ~/.tmux/plugins/tpm/bin/install_plugins

ENV HOME=/home/${USERNAME}
RUN mkdir -p /home/${USERNAME}/app
WORKDIR /home/${USERNAME}/app

# Ensure mise is activated in zsh
RUN echo 'eval "$(mise activate zsh)"' >> ~/.zshrc

# Trust the working directory and start zsh
CMD ["bash", "-c", "mise trust; exec zsh"]