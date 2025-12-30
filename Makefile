DOTPATH=~/dotfiles

install:
	@if ! command -v mise &> /dev/null; then \
		curl https://mise.jdx.dev/install.sh | sh; \
	fi
	mise install --yes
# 	~/bin/mise run setup

init: create_local-env link_zshrc link_tmux link_nvim link_sheldon link_mise
create_local-env:
	echo 'export PATH=$$PATH:/opt/nvim' > $(DOTPATH)/local-env.zsh
link: link_zshrc link_tmux link_nvim link_sheldon
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