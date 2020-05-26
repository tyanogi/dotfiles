DOTPATH=~/dotfiles

all: app-install zshrc vimrc tmux.conf
min: app-install zshrc tmux.conf
zshrc: dev_env
	ln -sf $(DOTPATH)/.zshrc ~/.zshrc
dev_env:
	touch dev_env.zsh
vimrc:
	ln -sf $(DOTPATH)/.vimrc ~/.vimrc
	ln -sf $(DOTPATH)/.vimshrc ~/.vimshrc
tmux.conf:
	ln -sf $(DOTPATH)/.tmux.conf ~/.tmux.conf

lns-clean:
	rm ~/.zshrc ~/.vimrc ~/.vimshrc ~/.tmux.conf

app-install:
	bash app_install.sh

