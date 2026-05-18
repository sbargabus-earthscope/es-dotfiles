[ -r ~/.bash_aliases ] && source ~/.bash_aliases
[ -r ~/.bash_functions ] && source ~/.bash_functions

# Set architecture flags
export ARCHFLAGS="-arch x86_64"
# Ensure user-installed binaries take precedence
#export PATH=/usr/local/bin:/usr/local/sbin:$PATH

#PS1='\h:\u:\w\$ '
#export PS1='\n[\w]\n\u@\h\$ '
#export PS1="\n[\w] \$(parse_git_branch)\n\u@\h\$ "

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

# use my .hostname file for hostname instead of system
if [ -e ~/.hostname ]; then
    HOSTNAME=`cat ~/.hostname`
    if [ "$color_prompt" = yes ]; then
        export PS1="\n[\[\033[01;32m\]\w\[\033[00m\]] \$(parse_git_fields)\n\[\033[01;34m\]\u@$HOSTNAME\[\033[00m\]\$ "
    else
        export PS1="\n[\w] \$(parse_git_fields)\n\u@$HOSTNAME\$ "
    fi
else
    if [ "$color_prompt" = yes ]; then
        export PS1="\n[\[\033[01;32m\]\w\[\033[00m\]] \$(parse_git_fields)\n\[\033[01;34m\]\u@\h\[\033[00m\]\$ "
    else
        export PS1="\n[\w] \$(parse_git_fields)\n\u@\h\$ "
    fi
fi
unset color_prompt force_color_prompt

export PATH=$PATH:~/bin:.
#export PATH=/usr/local/share/npm/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export ROOTDIR=/Users/scott
export PAGER=/usr/bin/less
export EDITOR=/opt/homebrew/bin/vim
export LESS="-SR"

alias histsum='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'

export HISTSIZE=1000000
export HISTCONTROL=ignorespace
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S")  $(hostname -s):$(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'
export LANG=en_US.UTF-8

set -o vi

if [ -f $(/opt/homebrew/bin/brew --prefix)/etc/bash_completion ]; then
  . $(/opt/homebrew/bin/brew --prefix)/etc/bash_completion
fi

# this fixes a broken kqueue, https://github.com/tmux/tmux/issues/475
export EVENT_NOKQUEUE=1

export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH="/usr/local/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"
