# ------------------------------------------------------------------------------------------------------------
# - * File: .zshrc
# - * Author: tyanogi
# ------------------------------------------------------------------------------------------------------------

source ~/dotfiles/local-env.zsh

# ---------------------------------------------------
# ▼ Vim Mode Settings ▼
# ---------------------------------------------------
# Enable Vi mode
bindkey -v

# Key bindings for Vi mode
# Insert mode: Ctrl+j to Normal mode
bindkey -M viins '^J' vi-cmd-mode
# Normal mode: Ctrl+j to Forward word
bindkey -a '^J' vi-forward-word

# Mode transition logic for prompt integration
function zle-line-init zle-keymap-select {
    if [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} == '' ]]; then
        export POSH_VI_MODE="INSERT"
    else
        export POSH_VI_MODE="NORMAL"
    fi
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# ---------------------------------------------------
# ▼ Tool Manager (Mise) ▼
# ---------------------------------------------------
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# ---------------------------------------------------
# ▼ Completion Settings ▼
# ---------------------------------------------------
autoload -U compinit
compinit

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Colors for completion
export LS_COLORS='di=1;36:fi=1;37:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ---------------------------------------------------
# ▼ History Settings ▼
# ---------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt inc_append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups

# ---------------------------------------------------
# ▼ Key Bindings (History Search) ▼
# ---------------------------------------------------
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# ---------------------------------------------------
# ▼ Command Alias ▼
# ---------------------------------------------------
alias vim='nvim'
alias t='tmux'

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'
alias gd='git diff'

# eza aliases (ls replacement)
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --git'
  alias ll='eza -la --icons --git --header --time-style=long-iso'
  export EZA_COLORS="di=1;36:ln=1;35:fi=37:xx=1;37:ex=31:so=32:pi=33:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
fi

# ---------------------------------------------------
# ▼ Plugin Settings (Zsh-autosuggestions) ▼
# ---------------------------------------------------
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1

# ---------------------------------------------------
# ▼ Prompt (Oh My Posh) ▼
# ---------------------------------------------------
if [ -f "$HOME/dotfiles/tyanogi.omp.yaml" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/dotfiles/tyanogi.omp.yaml)"
else
  eval "$(oh-my-posh init zsh)"
fi

# ---------------------------------------------------
# ▼ Plugin Management (Sheldon) ▼
# ---------------------------------------------------
# Should be called at the end
eval "$(sheldon source)"