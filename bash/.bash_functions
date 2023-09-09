#!/bin/env bash

getBaseName() {
  pwd | rev | cut -d '/' -f1 | rev;
}


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
