DOTPATH=~/dotfiles

init: create_local-env link_zshrc link_nvim
create_local-env:
	touch local-env.zsh
link: link_zshrc link_nvim
link_zshrc:
	ln -sf $(DOTPATH)/.zshrc ~/.zshrc
link_nvim:
	mkdir -p ~/.config/nvim
	ln -sf $(DOTPATH)/.config/nvim ~/.config/nvim