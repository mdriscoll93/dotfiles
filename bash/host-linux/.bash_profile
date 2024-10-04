#
# ~/.bash_profile
#
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#export GLFW_IM_MODULE=ibus
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
#export XMODIFIERS=@im=fcitx
export KITTY_CONFIG_DIRECTORY=~/.config/kitty

export PATH=$PATH:/usr/local/go/bin

export XDG_CONFIG_HOME=$HOME/.config
