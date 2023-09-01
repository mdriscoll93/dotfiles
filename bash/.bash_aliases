#!/bin/env bash

#-------------#
# bash_aliases#
#=============#

# i am unwell #
#-------------#
alias vi="vim"
alias docker="podman"
alias ll="ls -asl -F -T 0 -b -H -1 --color=always"
alias lt='ls --human-readable --size 1 -S --classify'
alias l="ls -CF"
alias less="less -rM"
alias cp="cp -p"
alias df="df -T"
alias du="du -h -c"
alias fdesktop="find /opt /snap /usr ~ /etc /lib* /srv /var /sbin /bin -name '*.desktop' 2>/dev/null"
alias grep="grep --color"

# pacman #
#--------#
alias orphans="pacman -Qtdq" # packages not required by any other
alias expliciti="pacman -Qetq" # explicitly installed packages not required by any other

# disks #
#-------#
alias dush='du -sh *|sort -r -n'
# view only mounted drives
alias mnt="mount | awk -F' ' '{ printf "%s\t%s\n", $1, $3; }' | column -t | egrep ^/dev/ | sort"

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

# kvm #
#-----#
alias kcli='podman run --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir quay.io/karmab/kcli'
alias kclishell='podman run --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir --entrypoint=/bin/bash quay.io/karmab/kcli'
alias kweb='podman run -p 9000:9000 --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir --entrypoint=/usr/bin/kweb quay.io/karmab/kcli'

#  apt pkg mgmt related   #
#-------------------------#
# apt exclusive: handles updates, package searching, cleaning, etc.
alias aptupdate='sudo apt-get update && sudo apt-get uprade -y && sudo apt-get autoclean -y && sudo apt-get auto-purge -y'
alias aptuu='sudo apt-get update && apt-get list --upgradable && sudo apt-get upgrade -y'
alias aptsearch='sudo apt-cache search'
alias aptshow='sudo apt-cache show'
alias aptup='sudo apt-get update'
alias aptin='sudo apt-get install'
alias aptdup='sudo apt-get dist-upgrade'
alias aptrem='sudo apt-get remove'
alias aptpg='sudo apt-get purge'
