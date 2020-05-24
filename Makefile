DOTPATH=~/dotfiles

all: zshrc vimrc tmux.conf
zshrc: dev_env
	ln -sf $(DOTPATH)/.zshrc ~/.zshrc
dev_env:
	touch dev_env.zsh
vimrc:
	ln -sf $(DOTPATH)/.vimrc ~/.vimrc
	ln -sf $(DOTPATH)/.vimshrc ~/.vimshrc
tmux.conf:
	ln -sf $(DOTPATH)/.tmux.conf ~/.tmux.conf

clean:
	rm ~/.zshrc ~/.vimrc ~/.vimshrc ~/.tmux.conf
