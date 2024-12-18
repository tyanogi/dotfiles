FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    zsh \
    sudo \
    fzf \
    ca-certificates \
    build-essential

ARG USERNAME=dev
RUN useradd -m -s /bin/zsh ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USERNAME}
WORKDIR /home/${USERNAME}

RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    ./squashfs-root/AppRun --version && \
    sudo mv squashfs-root / && \
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim && \
    rm -f nvim.appimage

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git clone https://github.com/tyanogi/dotfiles.git ./dotfiles && \
    echo 'export TERM=xterm-256color' > ./dotfiles/local-env.zsh && \
    cd ./dotfiles && \
    make link && \
    ./bin/oh-my-zsh-plugin-installer.sh && \
    cd ~

RUN nvim --headless "+Lazy! install" +qall

ENV HOME=/home/${USERNAME}

CMD ["zsh"]

