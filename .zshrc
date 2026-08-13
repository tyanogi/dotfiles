# ------------------------------------------------------------------------------------------------------------
# - * File: .zshrc
# - * Author: tyanogi
# ------------------------------------------------------------------------------------------------------------

# Machine-local settings. Not tracked by git, so it may not exist yet.
[ -f ~/dotfiles/local-env.zsh ] && source ~/dotfiles/local-env.zsh

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
# compinit itself is called at the very end of this file, after `sheldon source`
# has added plugin directories (zsh-completions) to $fpath. Calling it here would
# run against an incomplete $fpath and silently drop those completions.
autoload -U compinit

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
setopt INTERACTIVE_COMMENTS

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
# ▼ herdr ▼
# ---------------------------------------------------
# herdr は tmux (ls / a など) のような略記サブコマンドを受け付けないので shell 側で展開する
#   h            -> herdr                      (起動 / 再アタッチ)
#   h s l        -> herdr session list
#   h s a <name> -> herdr session attach <name>
#   h w l        -> herdr workspace list
#   h t l        -> herdr tab list
#   h p l        -> herdr pane list
#   h c c        -> herdr config check
#   h v r        -> herdr server reload-config
# 上記以外は herdr にそのまま渡すので `h status` や `h --version` も使える
h() {
  local -A _herdr_short=(
    "s l" "session list"
    "s a" "session attach"
    "w l" "workspace list"
    "t l" "tab list"
    "p l" "pane list"
    "c c" "config check"
    "v r" "server reload-config"
  )
  local expanded=${_herdr_short[${1:-} ${2:-}]}
  if [[ $# -ge 2 && -n $expanded ]]; then
    shift 2
    command herdr ${=expanded} "$@"
  else
    command herdr "$@"
  fi
}

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
# Should be called at the end (zsh-syntax-highlighting must be loaded last)
eval "$(sheldon source)"

# ---------------------------------------------------
# ▼ Completion Init ▼
# ---------------------------------------------------
# Must run after `sheldon source`, which is what puts zsh-completions on $fpath.
compinit

# herdr の補完は compdef を使うので compinit の後に読み込む。
# compdef h=herdr で短縮関数 h にも herdr と同じ補完を効かせる。
if command -v herdr &> /dev/null; then
  eval "$(herdr completion zsh)"
  compdef h=herdr
fi
