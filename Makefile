DOTPATH=~/dotfiles

init: create_local-env link_zshrc link_tmux link_herdr link_nvim link_sheldon link_mise
# local-env.zsh holds machine-specific settings and is gitignored, so it must
# never be clobbered on re-run. Only create it when it is missing.
create_local-env:
	test -f $(DOTPATH)/local-env.zsh || touch $(DOTPATH)/local-env.zsh
link: link_zshrc link_tmux link_herdr link_nvim link_sheldon link_mise
# -n is required for the directory links: without it a re-run dereferences the
# existing symlink and creates the new one *inside* the target directory.
link_zshrc:
	ln -sfn $(DOTPATH)/.zshrc ~/.zshrc
link_tmux:
	ln -sfn $(DOTPATH)/.tmux.conf ~/.tmux.conf
link_herdr:
	mkdir -p ~/.config/herdr
	ln -sfn $(DOTPATH)/.config/herdr/config.toml ~/.config/herdr/config.toml
link_nvim:
	mkdir -p ~/.config
	ln -sfn $(DOTPATH)/.config/nvim ~/.config/nvim
link_sheldon:
	mkdir -p ~/.config
	ln -sfn $(DOTPATH)/.config/sheldon ~/.config/sheldon
link_mise:
	mkdir -p ~/.config
	ln -sfn $(DOTPATH)/.config/mise ~/.config/mise
link_ghostty:
	mkdir -p ~/.config
	ln -sfn $(DOTPATH)/.config/ghostty ~/.config/ghostty
