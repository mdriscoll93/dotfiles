# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

#for file in ~/.bashrc.d/*.bashrc; 
#do 
#source "$file";
#done

# User specific environment and startup programs
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PATH=$PATH:/usr/local/go/bin
#export GOPATH="$HOME/go_projects"
#export GOBIN="$GOPATH/bin"
#export GOROOT=$HOME/go
#export PATH=$PATH:$GOROOT/bin