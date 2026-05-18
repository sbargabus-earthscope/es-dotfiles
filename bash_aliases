alias ls='ls -FC'
alias ll='ls -l'
alias la='ls -a'
alias lh='ls -lh'
alias m='more'
alias l='less'

#alias mntida='sshfs dbargabus@idadcc.ucsd.edu:/ida ~/slashida'
#alias umntida='umount ~/slashida'
alias gp='cd ~/Projects/'
alias hist='history | tail -50'
alias changeFirefox='vi /Users/scott/Library/ApplicationSupport/Firefox/Profiles/*/chrome/userChrome.css'
alias rh='history | tail -100 | less'

alias vdiff='vimdiff -c "set diffopt+=iwhite,icase" -c "syntax off"'

alias histsum='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'

alias gitnp='git --no-pager'
alias show_bash_functions='declare -F'
