# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
alias cdscripts='cd /home/pavlus/public_html/testing/scripts/WorkSpace/Pavlus_Scripts/'

alias ll='ls -alh --color=auto'
alias composer='composer -vv'

# set default permissions so we can collab with 'pavlus' group
# 0002 results in files being -rw-rw-r-- (664), dirs being drwxrwxr-x (775)
umask 0002

export VISUAL=emacs

# add git info to prompt
. ~/bin/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

# \u = username
# \w = working dir
# export PS1='\u \w$(__git_ps1 " (%s)")\$ '

#export PS1="\[$(tput bold)\]\[\033[38;5;13m\]\u@\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;10m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\[$(tput sgr0)\]\$(__git_ps1 ' (%s)')\n\\$ "
export PS1="$PS1\$(__git_ps1 '(%s)')\n\\$ "

## Make SSH auth socket symlink to SSH auth, to help using ssh-agent with tmux, et al.
if [ -S "$SSH_AUTH_SOCK" ] && [ ! -h "$SSH_AUTH_SOCK" ]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
