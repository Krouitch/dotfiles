# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

parse_git_branch()
{
  local BRANCH=$(git symbolic-ref HEAD --short 2> /dev/null)
  if [[ ! -z "$BRANCH" ]]
  then
    echo "($BRANCH)"
  fi
}

# PROMPT COLOURS
BLACK='\[\e[0;30m\]'      # Black - Regular
RED='\[\e[0;31m\]'        # Red
GREEN='\[\e[0;32m\]'      # Green
YELLOW='\[\e[0;33m\]'     # Yellow
BLUE='\[\e[0;34m\]'       # Blue
PURPLE='\[\e[0;35m\]'     # Purple
CYAN='\[\e[0;36m\]'       # Cyan
WHITE='\[\e[0;37m\]'      # White
BLACK_BOLD='\[\e[1;30m\]'   # Black - Bold
RED_BOLD='\[\e[1;31m\]'     # Red - Bold
GREEN_BOLD='\[\e[1;32m\]'   # Green - Bold
YELLOW_BOLD='\[\e[1;33m\]'  # Yellow - Bold
BLUE_BOLD='\[\e[1;34m\]'    # Blue - Bold
PURPLE_BOLD='\[\e[1;35m\]'  # Purple - Bold
CYAN_BOLD='\[\e[1;36m\]'    # Cyan - Bold
WHITE_BOLD='\[\e[1;37m\]'   # White - Bold
RESET='\[\e[0m\]'         # Text Reset

export PS1="\n${GREEN}\u${RESET}@${BLUE}\h${RESET} [${PURPLE}\w${RESET}] ${RED}{\$?}${RESET} ${YELLOW}\$(parse_git_branch)${WHITE_BOLD}\n=> ${RESET}"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# some usefull functions
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# Runs a ls immediately when you're inside a file.
cl() {
 if [ -d $1 ] ; then
  cd $1
  ll
 else
  echo "'$1' not a dir..."
 fi
}

