# ------------------------------------------------------------------------------------------------------------
# - * File: .tyanogi.zsh-theme
# - * Author: tyanogi
# ------------------------------------------------------------------------------------------------------------
autoload -Uz colors
colors

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue"

# キーバインドをvimにする
bindkey -v
bindkey -M viins '^J' vi-cmd-mode
bindkey -a '^J' vi-forward-word

function str_with_color() {
    echo "%{$fg[$1]%}$2%{$reset_color%}"
}
# git
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

# kubectx mapping
kubectx_mapping[kubernetes-admin@kubernetes]="raspi_k8s"
kubectx_mapping[kind-kind]=$(str_with_color cyan 'kind')
kubens_mapping[default]=$(str_with_color cyan 'default')
# kubens mapping
kubens_mapping[kube-public]=$(str_with_color cyan 'kube-public')
kubens_mapping[kube-system]=$(str_with_color cyan 'kube-system')

# Vimのモードを表示
function zle-line-init zle-keymap-select {
    VIM_NORMAL="%K{148}%F{028}--%k%f%K{148}%F{028} % NORMAL --%k%f"
    VIM_INSERT="%K{027}%F{white}--%k%f%K{027}%F{white} % INSERT --%k%f"
    RPROMPT="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# プロンプト表示    
USER_NAME=$(str_with_color blue '%n')
SEPARATOR1=$(str_with_color magenta '@')
HOST_NAME=$(str_with_color blue '%m')
SEPARATOR2=$(str_with_color magenta '->')
SEPARATOR3=$(str_with_color white ':')
CURRNET_DIRECTORY=$(str_with_color green '%~')
SEPARATOR4=$(str_with_color magenta '>> ')
TIME=$(str_with_color green '[%*]')

LINE1='${TIME} ${USER_NAME}${SEPARATOR1}${HOST_NAME}${vcs_info_msg_0_}($(kubectx_prompt_info)${SEPARATOR2}$(kubens_prompt_info))${SEPARATOR3}${CURRNET_DIRECTORY} '$'\n'
LINE2="${SEPARATOR4}"
PROMPT="${LINE1}${LINE2}"