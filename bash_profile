
# macosx
if [ "Darwin" = $(uname -s)  ]; then
export CLICOLOR=1
export LSCOLORS=gxfxaxdxcxegedabagacad
fi

# alias 
alias rm='rm -rf'
alias cp='cp -rf'
alias ll='ls -al'
alias sr='source ~/.bash_profile'
alias ipa='$XTOOL/bin/gen_ipa.sh'
alias vv='vim ~/.vimrc'

alias c='cat $XTOOL/license/license-c >>'
alias py='cat $XTOOL/license/license-python >>'
alias sh='cat $XTOOL/license/license-shell >>'

alias pj='cd ~/Projects'
alias bin='cd $XTOOL/bin'
alias md='cd ~/Markdown'

alias sshcopy='$XTOOL/bin/ssh-copy-id.sh' 

