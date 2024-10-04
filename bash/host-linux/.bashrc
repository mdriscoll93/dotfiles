#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

HISTSIZE=10000
HISTFILESIZE=200000

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
##

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}
#------------------------------------------------------------
# exports and customizations
################################################################################

ssh-reagent () {
  for agent in /tmp/ssh-*/agent.*; do
      export SSH_AUTH_SOCK=$agent
      if ssh-add -l 2>&1 > /dev/null; then
         echo Found working SSH Agent:
         ssh-add -l
         return
      fi
  done
  echo Cannot find ssh agent - maybe you should reconnect and forward it?
}
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" = *"$HOME/.local/bin:$HOME/bin:"* ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

. ~/.bash.d/cht.sh

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
source <(kitty + complete setup bash)

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

eval "$(register-python-argcomplete pipx)"
export GLFW_IM_MODULE=ibus
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export KITTY_CONFIG_DIRECTORY=~/.config/kitty
export PS1='\[\e[1;33m\]\W \[\e[1;36m\]\$ \[\e[0m\]'

#-------
# golang
############
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:/usr/local/bin:/$HOME/.local/share/JetBrains/Toolbox/scripts
#------
# kvm
###########
export LIBVIRT_DEFAULT_URI="qemu:///system" 

#------
# node
########### 
#source /usr/share/nvm/init-nvm.sh
LS_COLORS=(vivid generate ~/.config/vivid/rose-pine.yml)
export LS_COLORS
