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

# systemd #
#---------#
alias dayfail="journalctl --no-pager --since today --grep 'fail|error|fatal' --output json|jq '._EXE' | sort | uniq -c | sort --numeric --reverse --key 1"

# pacman #
#--------#
alias orphans="pacman -Qtdq"       # packages not required by any other
alias expliciti="pacman -Qetq"     # explicitly installed packages not required by any other
alias pacsyu="sudo pacman -Syu"	   # update database & upgrade
alias pacsy="sudo pacman -Sy"	   # update only
alias pacsu="sudo pacman -Su"	   # upgrade only
alias pacs="sudo pacman -S"	       # sync (install)
alias pacss="sudo pacman -Ss"	   # search package
alias pacsi="sudo pacman -Si"	   # details of the package
alias pacqs="sudo pacman -Qs"	   # search locally installed package
alias pacq="sudo pacman -Q"		   # version information
alias pacqi="sudo pacman -Qi"	   # details of the installed package
alias pacql="sudo pacman -Ql"	   # list all files of the package
alias pacrs="sudo pacman -Rs"  	   # remove package not leaving orphans
alias pacr="sudo pacman -R"	       # only remove selected package
alias pacrns="sudo pacman -Rns"	   # remove (not leaving any orphans) == clean removal + remove configs
alias pacrdd="sudo pacman -Rdd"	   # remove packages (breaking dependencies)
alias pacqm="sudo pacman -Qm"	   # packages installed from aur
alias pacqo="sudo pacman -Qo"      # file owned by $package
alias pacqkk="sudo pacman -Qkk"	   # check for any altered files


# disks #
#-------#
alias dush='du -sh *|sort -r -n'
alias mnt="mount | awk -F' ' '{ printf "%s\t%s\n", $1, $3; }' | column -t | egrep ^/dev/ | sort" # view only mounted drives
alias partview='lsblk --json | jq -c ".blockdevices[]|[.name,.size]"'

# files #
#-------#
# get back to that  place you want to remember for later - multiplexer-proof solution
alias pwdr='pwd > ~/.pwdremember'
alias cpv='rsync -ah --info=progress2'
alias cdr='cd $(cat ~/.pwdremember)'
alias histg='history |grep'
alias left='ls -t -1'
alias bkssh='tar --create --directory /home/$USER/bk --file - *| ssh root@teeth.markdriscoll.home "tar --directory /home/$USER --verbose --list --file -"'

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

# - - - - excuse my mess - - - - #

have() { command -v "$1" >&/dev/null; }
btar() { tar -czf - "$@" | base64; }
buntar() { base64 -d | tar -xvvzf -; }
alias bridge='bridge --color=auto'
count() { sort "$@" | uniq -c | sort -n -r | pager; }
alias demo='PS1="\\n\\$ "'
alias dnstrace='dnstracer -s .'
alias lchown='chown -h'
ldapls() {
	ldapsearch -LLL -o ldif-wrap=no "$@" 1.1 | grep ^dn: \
	| perl -MMIME::Base64 -pe 's/^(.+?):: (.+)$/"$1: ".decode_base64($2)/e'
}
alias lp='sudo netstat -lptu --numeric-hosts'
alias lpt='sudo netstat -lpt --numeric-hosts'
alias lpu='sudo netstat -lpu --numeric-hosts'
alias lsd='ls -d */'
alias lsh='ls -d .*'
alias lss='ls -sSr'
gerp() { grep $grepopt -ErIHn -Dskip --exclude-dir={.bzr,.git,.hg,.svn,_undo} "$@"; }
gpgfp() { gpg --with-colons --fingerprint "$1" | awk -F: '/^fpr:/ {print $10}'; }
alias hup='pkill -HUP -x'
alias init='telinit'
alias facl='getfacl -pt'
alias ll='ls -l'
alias loc='locate -A -b -i'
alias logoff='logout'
alias lspart='lsblk -o name,partlabel,size,fstype,label,mountpoint'
mtr() { settitle "$HOSTNAME: mtr $*"; command mtr --show-ips "$@"; }
alias mtrr='mtr --report-wide --report-cycles 3 --show-ips --aslookup --mpls'
mvln() { mv "$1" "$2" && sym -v "$2" "$1"; }
alias nmap='nmap --reason'
alias nm-con='nmcli -f name,type,autoconnect,state,device con'
alias plink='plink2 -no-antispoof'
alias pring='prettyping'
alias py='python3'
alias py2='python2'
alias py3='python3'
alias re='hash -r && SILENT=1 . ~/.bashrc && echo reloaded .bashrc && :'
alias ere='set -a && . ~/.bash_profile && set +a && echo reloaded .bash_profile && :'
alias rawhois='do: whois -h whois.ra.net --'
alias riswhois='do: whois -h riswhois.ripe.net --'
alias rot13='tr N-ZA-Mn-za-m A-Za-z'
sp() { printf '%s' "$@"; printf '\n'; }
splitext() { split -dC "${2-32K}" "$1" "${1%.*}-" --additional-suffix=".${1##*.}"; }
alias sudo='sudo ' # for alias expansion in sudo args
alias telnets='telnet-ssl -z ssl'
_thiscommand() { history 1 | sed "s/^\s*[0-9]\+\s\+([^)]\+)\s\+$1\s\+//"; }
tigdiff() { diff -u "$@" | tig; }
alias todo:='todo "$(_thiscommand todo:)" #'
alias traceroute='traceroute -N3'
alias tracert='traceroute -I'
wim() { local file=$(which "$1") && [[ $file ]] && editor "$file" "${@:2}"; }
xar() { xargs -r -d '\n' "$@"; }
alias xf='ps xf -O ppid'
alias xx='chmod a+rx'
alias '~'='grep -E'
alias '~~'='grep -E -i'
-() { cd -; }
alias ssdate='date "+%Y%m%d"'
alias sdate='date "+%Y-%m-%d"'
alias mmdate='date "+%Y-%m-%d %H:%M"'
alias mdate='date "+%Y-%m-%d %H:%M:%S %z"'
alias ldate='date "+%A, %B %-d, %Y %H:%M"'
alias mboxdate='date "+%a %b %_d %H:%M:%S %Y"'
alias mimedate='date "+%a, %d %b %Y %H:%M:%S %z"' # RFC 2822
alias isodate='date "+%Y-%m-%dT%H:%M:%S%z"' # ISO 8601
alias good='git bisect good'
alias bad='git bisect bad'
grepopt="--color=auto"
alias grep='grep $grepopt'
alias egrep='grep -E $grepopt'
alias fgrep='grep -F $grepopt'
