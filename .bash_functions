#!/bin/env bash

getBaseName() {
  pwd | rev | cut -d '/' -f1 | rev;
}

have() { command -v "$1" >&/dev/null; }

createVenv() {
# dest="${PWD##*/}"
# You can run the function `getBaseName` and assign its output like this:
dest=$(getBaseName)

if python3 -m venv "$dest" ; then
  cd "$dest"
  source "./bin/activate"
  [ ! -f "./requirements.txt" ] || pip install -r requirements.txt
  echo You are now in new venv environment
else
   echo "Failed to create 'venv' environment" >&2
fi;
}

createVenvNode() {
# dest="${PWD##*/}"
# You can run the function `getBaseName` and assign its output like this:
dest=$(getBaseName)

if python3 -m venv "$dest" ; then
   cd "$dest"
   source "./bin/activate"
   # You can test the exit status of these commands with an if statement too
   pip install nodeenv && nodeenv -p
   echo You are now in new venv environment
else
   echo "Failed to create 'venv' environment" >&2;
 fi
}

ex() {

        if [ -f "${1}" ] ; then
        case "${1}" in
                *.a)          ar  -xv      "${1}"         ;;
                *.tgz)        tar -xvzf    "${1}"         ;;
                *.tar.gz)     tar -xvzf    "${1}"         ;;
                *.tar.bz2)    tar -xvjf    "${1}"         ;;
                *.tar.xz)     tar -xvJf    "${1}"         ;;
                *.bz2)        bunzip2      "${1}"         ;;
                *.rar)        unrar  x -o- "${1}"         ;;
                *.gz)         gunzip -vk   "${1}"         ;;
                *.zip)        unzip        "${1}"         ;;
                *.7z)         7z     x     "${1}"         ;;
                *) echo "'${1}' unknow extension to extract!" ;;
        esac
  else
        echo "'${1}' is not a valid file"
  fi
}

if have xclip; then
	alias psel='xclip -out -selection primary'
	alias gsel='xclip -in -selection primary'
	alias pclip='xclip -out -selection clipboard'
	alias gclip='xclip -in -selection clipboard'
	alias lssel='psel -target TARGETS'
	alias lsclip='pclip -target TARGETS'
elif have xsel; then
	alias psel='xsel -o -p -l /dev/null'
	alias gsel='xsel -i -p -l /dev/null'
	alias pclip='xsel -o -b -l /dev/null'
	alias gclip='xsel -i -b -l /dev/null'
fi

clip() {
	if (( $# )); then
		echo -n "$*" | gclip
	elif [[ ! -t 0 ]]; then
		gclip
	else
		pclip
	fi
}

alias tlsc='tlsg'

tlsg() {
	if [[ $2 == -p ]]; then
		set -- "$1" "${@:3}"
	fi
	local host=$1 port=${2:-443}
	gnutls-cli "$host" -p "$port" "${@:3}"
}

tlso() {
	if [[ $2 == -p ]]; then
		set -- "$1" "${@:3}"
	fi
	local host=$1 port=${2:-443}
	case $host in
	    *:*) local addr="[$host]";;
	    *)   local addr="$host";;
	esac
	openssl s_client -connect "$addr:$port" -servername "$host" \
		-verify_hostname "$host" -status -no_ign_eof -nocommands "${@:3}"
}

tlsb() {
	if [[ $2 == -p ]]; then
		set -- "$1" "--port=$3" "${@:4}"
	fi
	botan tls_client "$@"
}

tlscert() {
	if [[ $2 == -p ]]; then
		set -- "$1" "${@:3}"
	fi
	local host=$1 port=${2:-443}
	if have gnutls-cli; then
		tlsg "$host" "$port" --insecure --print-cert
	elif have openssl; then
		tlso "$host" "$port" -showcerts
	fi < /dev/null
}

alias sslcert='tlscert'

lspkcs12() {
	if [[ $1 == -g ]]; then
		certtool --p12-info --inder "${@:2}"
	elif [[ $1 == -n ]]; then
		pk12util -l "${@:2}"
	elif [[ $1 == -o ]]; then
		openssl pkcs12 -info -nokeys -in "${@:2}"
	fi
}

x509fp() {
	local file=${1:-/dev/stdin}
	openssl x509 -in "$file" -noout -fingerprint -sha256 | sed 's/.*=//' | tr A-F a-f
}

x509subj() {
	local file=${1:-/dev/stdin}
	openssl x509 -in "$file" -noout -subject -nameopt RFC2253 | sed 's/^subject=//'
}

x509subject() {
	local file=${1:-/dev/stdin}
	openssl x509 -in "$file" -noout -subject -issuer -nameopt multiline,dn_rev
}

# service management

if have systemctl && [[ -d /run/systemd/system ]]; then
	start()   { sudo systemctl start "$@";   _status "$@"; }
	stop()    { sudo systemctl stop "$@";    _status "$@"; }
	restart() { sudo systemctl restart "$@"; _status "$@"; }
	reload()  { sudo systemctl reload "$@";  _status "$@"; }
	status()  { SYSTEMD_PAGER='cat' systemctl status -a "$@"; }
	_status() { sudo SYSTEMD_PAGER='cat' systemctl status -a -n0 "$@"; }
	alias enable='sudo systemctl enable'
	alias disable='sudo systemctl disable'
	alias list='systemctl list-units -t path,service,socket --no-legend'
	alias userctl='systemctl --user'
	alias u='systemctl --user'
	alias y='systemctl'
	ustart()   { userctl start "$@";   userctl status -a "$@"; }
	ustop()    { userctl stop "$@";    userctl status -a "$@"; }
	urestart() { userctl restart "$@"; userctl status -a "$@"; }
	ureload()  { userctl reload "$@";  userctl status -a "$@"; }
	alias ulist='userctl list-units -t path,service,socket --no-legend'
	alias lcstatus='loginctl session-status $XDG_SESSION_ID'
	alias tsd='tree /etc/systemd/system'
	cgls() { SYSTEMD_PAGER='cat' systemd-cgls "$@"; }
	usls() { cgls "/user.slice/user-$UID.slice/$*"; }
fi

