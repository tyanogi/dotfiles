# ------------------------------------------------------------------------------------------------------------
# - * File: .zshrc
# - * Author: tyanogi
# ------------------------------------------------------------------------------------------------------------
autoload -Uz colors
colors

# 補完機能
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=2
# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''
# キーバインドをvimにする
bindkey -v
bindkey -M viins '^J' vi-cmd-mode
bindkey -a '^J' vi-forward-word
# zshプロンプトにモード表示
# 設定1
function zle-line-init zle-keymap-select {
    VIM_NORMAL="%K{148}%F{green}--%k%f%K{148}%F{green} % NORMAL --%k%f"
    VIM_INSERT="%K{027}%F{white}--%k%f%K{027}%F{white} % INSERT --%k%f"
    RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
    zle reset-prompt
}

# vcs_infoロード    
autoload -Uz vcs_info    
# PROMPT変数内で変数参照する    
setopt prompt_subst    
# vcsの表示    
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
# プロンプト表示直前にvcs_info呼び出し    
precmd() { vcs_info }    
# プロンプト表示    
local p_cdir='%{$fg[blue]%}%n%{$reset_color%}%{$fg[magenta]%}@%{$reset_color%}%{$fg[blue]%}%m%{$reset_color%}${vcs_info_msg_0_}:%{$fg[green]%}%~%f%{$reset_color%}$VIMODE '$'\n'
local p_info="%{$fg[magenta]%}>> %{$reset_color%}"

PROMPT="$p_cdir$p_info"
RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"

zle -N zle-line-init
zle -N zle-keymap-select

# 入力したコマンドが存在せず, かつディレクトリ名が一致するならcd
setopt auto_cd
# "cd [Tab]" 移動履歴の表示
setopt auto_pushd
# pushdした時にディレクトリがすでにスタックに含まれていれば追加しない 
setopt pushd_ignore_dups
# 入力したコマンドがすでにコマンド履歴に含まれる場合、履歴から古いほうのコマンドを削除する
setopt hist_ignore_all_dups
# コマンドがスペースで始まる場合、コマンド履歴に追加しない
setopt hist_ignore_space
# コマンド訂正
setopt correct
# 補完候補を詰めて表示
setopt list_packed
# ビープ音off
setopt nolistbeep

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# プロセスを横断してヒストリを共有
setopt inc_append_history
# ヒストリの共有の有効化
setopt share_history
# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
# ヒストリに追加されるコマンドが古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# 大文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ディレクトリの移動
alias ...='cd ../..'
alias ....='cd ../../..'
# タイプミス
alias vikm='vim'
# ディレクトリに色をつける
autoload -U compinit
compinit
export LSCOLORS=exfxcxdxbxegedabagacad
#export LSCOLORS=cxfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

alias ls="ls -GF"
alias gls="gls --color"

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

disable r

# timuxの自動起動
PERCOL=fzf
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi

source ~/dotfiles/dev_env.zsh

