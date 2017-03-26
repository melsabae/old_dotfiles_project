# Created by newuser for 5.3.1
autoload -Uz compinit promptinit
compinit
promptinit

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
setopt noclobber

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias sl='ls'
    alias ll='ls -Altrh --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    # color output even through pipes
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    # less strips color sometimes
    alias less='less -R'

    alias vim.tiny='vim'
    alias vi='vim'
    alias vm='vim'
    alias im='vim'
    alias pythong='py'
    alias py='python2.7'
    alias cls='clear; ls'
    alias cll='clear; ll'
    alias lsl='ls -1 | wc -l'
    alias gcc='gcc -mtune=native -Wall'
    alias calc='gnome-calculator &'
    alias lst='ll -t'
                alias reflector='sudo reflector --verbose --country "United States" -l 20 --sort rate --save /etc/pacman.d/mirrorlist'
                alias pacup='sudo su -c "pacman -Syy; pacman -Syu; pacman -Scc"'
                alias top='htop'
fi

