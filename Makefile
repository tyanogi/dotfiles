DOTPATH=~/dotfiles

init: create_local-env link_zshrc link_tmux link_nvim link_sheldon link_mise
# local-env.zsh holds machine-specific settings and is gitignored, so it must
# never be clobbered on re-run. Only create it when it is missing.
create_local-env:
	test -f $(DOTPATH)/local-env.zsh || touch $(DOTPATH)/local-env.zsh
link: link_zshrc link_tmux link_nvim link_sheldon link_mise
link_zshrc:
	ln -sf $(DOTPATH)/.zshrc ~/.zshrc
link_tmux:
	ln -sf $(DOTPATH)/.tmux.conf ~/.tmux.conf
link_nvim:
	mkdir -p ~/.config
	ln -sf $(DOTPATH)/.config/nvim ~/.config/nvim
link_sheldon:
	ln -sf $(DOTPATH)/.config/sheldon ~/.config/sheldon
link_mise:
	ln -sf $(DOTPATH)/.config/mise ~/.config/mise
link_ghostty:
	ln -sf $(DOTPATH)/.config/ghostty ~/.config/ghostty
