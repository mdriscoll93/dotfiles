#!/bin/bash

#-------------#
# bash_aliases#
#=============#

# disk, storage, file manipulaition #
alias dush='du -sh *|sort -r -n'
alias lt='ls --human-readable --size 1 -S --classify'
alias cpv='rsync -ah --info=progress2'
# view only mounted drives
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"

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

# file related #
#--------------#
# get back to that  place you want to remember for later - multiplexer-proof solution
alias pwdr='pwd > ~/.pwdremember'
alias cdr='cd $(cat ~/.pwdremember)'
# grep for a command in history
alias histg='history |grep'
# sort by modification time
alias left='ls -t -1'

# git related
alias startgit='cd `git rev-parse --show-toplevel` && git checkout main && git pull'
alias cg='cd `git rev-parse --show-toplevel`'
