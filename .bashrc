
if [[ $HOSTNAME == vm-aprisa ]]; then
    return
fi

export DOLPHINENV_DIR=~/dolphin-environment
export PATH=/share/apps/dolphin/solutions/2019_Q2a0/licensing/FLEXlm\:$PATH
export PATH=$DOLPHINENV_DIR/BIN\:$PATH

###############################
###  ENVIRONNEMENT DOLPHIN  ###
###############################
#Test HOST IP to define location (France,Canada,Israel) and data server name
if [[ -z $DATASTORAGE ]]; then
  case $(hostname -i | cut -f3 -d.) in
    50 )
      export DATASTORAGE=manic
      ;;
    * )
      export DATASTORAGE=scorpion
      ;;
  esac
fi

# export MODULEPATH=$HOME/mymodules:$MODULEPATH

export MODULEPATH=/net/varan/volume1/PROJETS/VEP/USERS/fbe/vep/PROJECT:${MODULEPATH}
#export MODULEPATH=/net/varan/volume1/PROJETS/VITEC-G60/USERS/fbe/G60_speak/SETUP/PROJECT:${MODULEPATH}
export MODULEPATH=/net/varan/volume1/PROJETS/VITEC-G60/USERS/fbe/G60_unified_flow/project/setup:${MODULEPATH}
export MODULEPATH=/net/varan/volume1/PROJETS/ULPMARK/USERS/fbe/ULPMARK/PROJECT:${MODULEPATH}
export MODULEPATH=/net/varan/volume1/PROJETS/TCB/USERS/fbe/TCB_speak/SETUP/PROJECT:${MODULEPATH}
export MODULEPATH=/net/varan/volume1/PROJETS/ABB-PVT-AR.01/USERS/fbe/ABB-PVT-AR.01/PROJECT:${MODULEPATH}
export MODULEPATH=/net/varan/volume1/PROJETS/ABB-PVT-AF.01/USERS/fbe/ABB-PVT-AF.01_local/project/setup:${MODULEPATH}
export MODULEPATH=/net/varan/volume1/PROJETS/meErKat/USERS/fbe/meErKat_local/project/setup:${MODULEPATH}
export MODULEPATH=/net/varan/volume1/PROJETS/TINYRAPTOR/users/fbe/TINYRAPTOR_local/project/setup:${MODULEPATH}
export MODULEPATH=/net/varan/volume1/PROJETS/PANTHER/USERS/fbe/PANTHER_local/project/setup:${MODULEPATH}


# Adding module development project in first position so it can be debugged easily

export MODULEPATH=${HOME}/modules/eda_tools:${MODULEPATH}
export MODULEPATH=${HOME}/modules/eda_licenses:${MODULEPATH}

module load license/meylan


if [ ${BASH_VERSINFO:-0} -ge 3 ] && [ -r ${MODULESHOME}/init/bash_completion ]; then
  . ${MODULESHOME}/init/bash_completion
fi

export PATHENV=$DOLPHINENV_DIR/dolphin
export LOCALHOST=$(echo $HOST | sed 's/\..*//')
export DOLPHIN_CONFIG_PATH=$PATHENV
export EQUIPE=$(grep '^[^#]*'$LOCALHOST'[    ]' $PATHENV/hosts | sed 's/^[^#][^#]*#[^#]*#\([^#]*\)#.*/\1/')
for machine in $(grep '^[^#].*\[DIS\]' $PATHENV/hosts | sed 's/^[0-9]*\.[0-9]*\.[0-9]*\.[0-9 ]*\s*\([^#]*\)#.*/\1/'); do
  alias $machine="export DISPLAY=${machine}:0.0 ; echo 'DISPLAY = ${machine}:0.0'"
done
###############################
###############################
###############################


## Change the umask to allow rw for the group but only read for the others when creating a new file or folder
umask 002

## Avoids issues when reading decimal numbers
export LANG=en_US.UTF-8

## Requested for some tools
export TERM=xterm

#Default SVN_EDITOR
export SVN_EDITOR=vim

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#Add autocompletion for Makefiles:
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make

#Enable bash completion
if [[ -r /etc/profile.d/bash_completion.sh  ]]; then
    source /etc/profile.d/bash_completion.sh
else
    echo "-W- Improved Bash completion is unavailable"
fi

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

function Color() {
  echo "$(tput setaf $1)"
}
function ResetColor() {
  echo "$(tput sgr0)"
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

function LastStatus() {
    local last_status_n=$?
    local last_status=$last_status_n
    local reset=$(ResetColor)

    local failure="✘"
    local success="✔"

    if [[ "$last_status_n" -gt 0 ]]; then
        last_status="$(Color 5)${failure} ($last_status_n)$reset"
    else
        last_status="$(Color 2)$success$reset"
    fi

    echo "$last_status"
}



export PS1="\n${GREEN}\u${RESET}@${CYAN}\h${RESET} [${PURPLE}\w${RESET}] ${CYAN}(\D{%H:%M:%S})${RESET} \$(LastStatus) ${YELLOW}\$(parse_git_branch)${WHITE_BOLD}\n=> ${RESET}"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -h --color=auto'
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
          *.tar.xz)    tar xf $1      ;;
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

#Allows to source CSH scripts in bash
source_csh () {
   exec csh -c " source $*; setenv ALREADY_SOURCED \"$ALREADY_SOURCED:$*:\"; exec bash"
}


# Dolphin environment
export PRODUCTS_LINES=/scorpion/Products-Lines

#Tool installation scripts
source $DOLPHINENV_DIR/BASH/install_tools.sh
source $DOLPHINENV_DIR/BASH/tools.sh


# Set colors for ls commands that do not rip off your eyes:
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=37:cd=1;37:su=1;31:sg=1;31:tw=1;34:ow=1;34"

