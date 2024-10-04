#!/bin/bash

# Detect the OS type using uname
OS_TYPE=$(uname -s)

case "$OS_TYPE" in
    "Linux")
        # Further distinguish between different Linux systems if needed
        if grep -q Microsoft /proc/version; then
            stow bash/host-windows
            stow vim/host-windows
            stow zsh/host-windows
        else
            stow bash/host-linux
            stow vim/host-linux
            stow zsh/host-linux
        fi
        ;;
    "Darwin")
        stow bash/host-mac
        stow vim/host-mac
        stow zsh/host-mac
        ;;
    *)
        echo "Unknown OS: $OS_TYPE. No host-specific configuration applied."
        ;;
esac

# Apply common dotfiles
stow git kitty kcli shellcheck solaar

