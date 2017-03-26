# Created by newuser for 5.3.1
autoload -Uz compinit promptinit
compinit
promptinit

# This will set the default prompt to the walters theme
prompt walters

# vi keybound menu selection
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey -v

source ~/dotfiles/zsh-git-prompt/zshrc.sh
# non-zero status code
# bold hostname, regular username, prompt and privilege
PROMPT='%(?..[%F{red}%?%f] )%F{cyan}%B%m%b%f %F{yellow}%n%f %S>_%#%s '

# home replaced with ~, up to 2 dir max, and git status of repo if available
RPROMPT='%U%2~%u $(git_super_status)'

# spelling correction
setopt correct
