DOTPATH=~/dotfiles

all: install zshrc vimrc tmux.conf
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

app-install:
ifeq ($(shell uname -a | grep -o Ubuntu),Ubuntu)
	echo "Ubuntu"
	sudo apt update
	sudo apt install -y vim-gtk tmux zsh git
	sed -i 's/.*default-shell/#&/g' $(DOTPATH)/.tmux.conf
	chsh -s $(shell which zsh)
endif
ifeq ($(shell uname),Darwin)
	echo "Mac"
else
	echo "other"
endif

