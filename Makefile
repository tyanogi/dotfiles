DOTPATH=~/dotfiles

all: app-install zshrc nvim-setup tmux.conf
min: app-install zshrc tmux.conf
zshrc: dev_env
	ln -sf $(DOTPATH)/.zshrc ~/.zshrc
dev_env:
	touch dev_env.zsh
vimrc:
	mkdir -p ~/.config/nvim
	ln -sf $(DOTPATH)/.vimrc ~/.config/nvim/init.vim
	#ln -sf $(DOTPATH)/.vimshrc ~/.vimshrc
nvim-setup: vimrc
	bash dein.sh
tmux.conf:
	ln -sf $(DOTPATH)/.tmux.conf ~/.tmux.conf

lns-clean:
	rm ~/.zshrc ~/.vimrc ~/.vimshrc ~/.tmux.conf

app-install:
	bash app.sh

