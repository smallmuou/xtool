
# macosx
if [ "Darwin" = $(uname -s)  ]; then
export CLICOLOR=1
export LSCOLORS=gxfxaxdxcxegedabagacad
fi

export PATH=$PATH:$XTOOL/bin

# alias 
alias rm='rm -rf'
alias cp='cp -rf'
alias ll='ls -al'
alias sr='source ~/.bash_profile'
alias ipa='$XTOOL/bin/gen_ipa.sh'
alias vv='vim ~/.vimrc'
alias sshcopy='$XTOOL/bin/ssh-copy-id.sh' 
alias pbcat='$XTOOL/bin/pbcat.sh'
alias tag='$XTOOL/bin/tag.sh'
alias grep='grep --color'
alias qrdomain='echo "7ximmr.com1.z0.glb.clouddn.com"|pbcopy'

alias c='cat $XTOOL/license/license-c >>'
alias py='cat $XTOOL/license/license-python >>'
alias sh='cat $XTOOL/license/license-shell >>'

alias pj='cd ~/Projects'
alias bin='cd $XTOOL/bin'
alias md='cd ~/Markdown'
alias dt='cd ~/Desktop'




