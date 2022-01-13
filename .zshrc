# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/stefan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --height=80%"

plugins=(
    fzf
    git
    history-substring-search
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
)

# default theme
# ZSH_THEME="robbyrussell"
#ZSH_THEME="alanpeabody"

source /usr/share/nvm/init-nvm.sh

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
