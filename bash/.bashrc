stty -ixon

set -o vi
bind -m vi-insert "\C-l":clear-screen

HISTCONTROL=ignoreboth

export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export TERMINAL="termite"
export HDD="/media/$USER/hdd"
export FILE_MANAGER="$TERMINAL -e ranger"
export FILE_MANAGER_HDD="$TERMINAL -e 'ranger ${HDD}'"
export HISTFILE="$HOME/.cache/bash/history"
export LESSHISTFILE="-"
export NO_AT_BRIDGE=1
export PATH="~/.config/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export PS1="\[$(tput bold)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]@\h:\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;28m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;28m\]>\[$(tput sgr0)\]"

man() {
	env \
	LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	LESS_TERMCAP_md=$(printf "\e[1;31m") \
	LESS_TERMCAP_me=$(printf "\e[0m") \
	LESS_TERMCAP_se=$(printf "\e[0m") \
	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

calc() {
	local result=""
	result="$(printf "scale=10;%s\\n" "$*" | bc --mathlib | tr -d '\\\n')"

	if [[ "$result" == *.* ]]; then
		printf "%s" "$result" |
			sed -e 's/^\./0./'  \
			-e 's/^-\./-0./' \
			-e 's/0*$//;s/\.$//'
	else
		printf "%s" "$result"
	fi
	printf "\\n"
}

extract () {
    if [ -f "$1" ] ; then
          case "$1" in
                  *.tar.bz2)   tar xjvf $1    ;;
	          *.tar.gz)    tar xzvf $1    ;;
	          *.bz2)       bunzip2 $1     ;;
	          *.rar)       unrar x $1     ;;
	          *.gz)        gunzip $1      ;;
	          *.tar)       tar xvf $1     ;;
	          *.tbz2)      tar xjvf $1    ;;
	          *.tgz)       tar xzvf $1    ;;
	          *.zip)       unzip $1       ;;
	          *.Z)         uncompress $1  ;;
	          *.7z)        7za e $1        ;;
	          *)     echo "'$1' cannot be extracted via extract()" ;;
	esac
    else
        echo "'$1' is not a valid file"
    fi
}

for config in "$HOME"/.config/bashrc.d/* ; do
    source "$config"
done

unset -v config
