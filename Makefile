DOTPATH=~/dotfiles

init: create_local-env link_zshrc link_nvim
create_local-env:
	echo "export PATH="PATH:/opt/nvim/" > $(DOTPATH)/local-env.zsh
link: link_zshrc link_tmux link_nvim
link_zshrc:
	ln -sf $(DOTPATH)/.zshrc ~/.zshrc
link_tmux:
	ln -sf $(DOTPATH)/.tmux.conf ~/.tmux.conf
link_nvim:
	mkdir -p ~/.config
	ln -sf $(DOTPATH)/.config/nvim ~/.config/nvim