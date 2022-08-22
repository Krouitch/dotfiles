# ************************************************************************************************
# *                 ___          *
# *               /      \ ___   *
# *             /     . _-_-_-   *
# *      ___ /           /       *
# *   #/               /    #    *	ENVIRONNEMENT JAZZ LAYOUT
# *  /                /          *
# * |____           /       #    *
# *      \         /             *
# *   #   |       /         #    * AUTHOR: PAB
# *       |      /               *
# *   #   |     /           #    *
# *      /     /                 * DATE: 23/02/2009
# * _ # /    /              #    *
# *| \_/   /                     *
# * \    /                  #    *
# * |  / #   #   #   #   #       *
# * |/                           *
# ************************************************************************************************
# * MODIF:
# *
# * COMMENT:	Fichier cShell d'environnement type pour utilisateur
# *
# ************************************************************************************************

# This file should not be modified locally as customization scripts are cshrc_interactive and cshrc_batch

setenv PRODUCTS_LINES /net/scorpion-pl/Scorpion-pl/Products-Lines

setenv PATH /share/apps/dolphin/solutions/2019_Q2a0/licensing/FLEXlm\:$PATH

setenv PATH /share/apps/dolphin_env/BIN\:$PATH

source ~/.cshrc_batch

########################################
###  ENVIRONNEMENT DOLPHIN FRANCE    ###
########################################
source ~/dolphin-environment/dolphin/dolphin.cshrc > /dev/null
#Load common environment for tool loading

## Avoids issues when reading decimal numbers
unsetenv LANG
setenv LANG en_US.UTF-8

## Requested for some tools
setenv TERM xterm

#####################################################################################################
#####################################################################################################
##########################Everything under these lines is not evaluated in non-interactive shells
#####################################################################################################
#####################################################################################################
if (! $?prompt) goto cshrc_end


#pas de Caps Lock
xmodmap -e 'clear Lock'

#To enable CTRL+arrows to move you word by word in a shell
bindkey '^[[1;5D'   backward-word           # ctrl+left
bindkey '^[[1;5C'   forward-word            # ctrl+right

#Default SVN_EDITOR
setenv SVN_EDITOR vim

### Usr Scripts ###
source ~/.cshrc_interactive

cshrc_end:
