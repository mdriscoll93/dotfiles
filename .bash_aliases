#!/bin/env bash

#-------------#
# bash_aliases#
#=============#

# i am unwell #
#-------------#
alias vi="vim"
alias vimhist='vim ~/.bash_history'
alias docker="podman"
alias ltrah="ls -ltrah --color=always"
alias ll="ls -asl -F -T 0 -b -H -1 --color=always"
alias lt='ls --human-readable --size -1 -S --classify'
alias l="ls -CF"
alias less="less -rM"
alias cp="cp -p"
alias df="df -T"
alias du="du -h -c"
alias fdesktop="find /opt /snap /usr ~ /etc /lib* /srv /var /sbin /bin -name '*.desktop' 2>/dev/null"
alias grep="grep --color"
alias s="kitten ssh"

# pacman #
#--------#
alias orphans="sudo pacman -Qtdq"   # packages not required by any other
alias expliciti="sudo pacman -Qetq" # explicitly installed packages not required by any other
alias pacsyu="sudo pacman -Syu"	    # update database & upgrade
alias pacsy="sudo pacman -Sy"	    # update only
alias pacsu="sudo pacman -Su"	    # upgrade only
alias pacs="sudo pacman -S"	        # sync (install)
alias pacss="sudo pacman -Ss"	    # search package
alias pacsi="sudo pacman -Si"	    # details of the package
alias pacqs="sudo pacman -Qs"	    # search locally installed package
alias pacq="sudo pacman -Q"		    # version information
alias pacqi="sudo pacman -Qi"	    # details of the installed package
alias pacql="sudo pacman -Ql"	    # list all files of the package
alias pacrs="sudo pacman -Rs"  	    # remove package not leaving orphans
alias pacr="sudo pacman -R"	        # only remove selected package
alias pacrns="sudo pacman -Rns"	    # remove (not leaving any orphans) == clean removal + remove configs
alias pacrdd="sudo pacman -Rdd"	    # remove packages (breaking dependencies)
alias pacqm="sudo pacman -Qm"	    # packages installed from aur
alias pacqo="sudo pacman -Qo"       # file owned by $package
alias pacqkk="sudo pacman -Qkk"	    # check for any altered files

# date/time #
#-----------#
utcdate='date -u +"%Y-%m-%dT%H:%M:%S"'
utcoffset='date -u +"%:z"'

# disks #
#-------#
alias dush='du -sh *|sort -r -n'
# view only mounted drives
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | grep -E ^/dev/ | sort"

# files #
#-------#
# get back to that  place you want to remember for later - multiplexer-proof solution
alias pwdr='pwd > ~/.pwdremember'
alias cpv='rsync -ah --info=progress2'
alias cdr='cd $(cat ~/.pwdremember)'
# grep for a command in history
alias histg='history |grep'
# sort by modification time
alias left='ls -t -1'

# git #
#-----#
alias startgit='cd `git rev-parse --show-toplevel` && git checkout main && git pull'
alias cg='cd `git rev-parse --show-toplevel`'

# containerd #
#------------#
#alias docker='podman'

# kvm #
#-----#
alias gonotes='docker run -it --rm -p 8888:8888 -v "${PWD}":/home/jovyan/work janpfeifer/gonb_jupyterlab:latest'
alias kcli='podman run --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir quay.io/karmab/kcli'
alias kclishell='podman run --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir --entrypoint=/bin/bash quay.io/karmab/kcli'
alias kweb='podman run -p 9000:9000 --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir --entrypoint=/usr/bin/kweb quay.io/karmab/kcli'
