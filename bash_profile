
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
alias untag='rm -rf cscope.* tags'
alias grep='grep --color'
alias qndomain='echo "http://7ximmr.com1.z0.glb.clouddn.com/"|pbcopy'
alias yuedu='yuedu.sh'
alias udid='system_profiler SPUSBDataType | sed -n  -e "/iPad/,/Extra/p" -e "/iPhone/,/Extra/p"'

alias fc='cat $XTOOL/license/license-c >>'
alias fpy='cat $XTOOL/license/license-python >>'
alias fsh='cat $XTOOL/license/license-shell >>'

alias pj='cd ~/Projects'
alias bin='cd $XTOOL/bin'
alias md='cd ~/Markdown'
alias dt='cd ~/Desktop'




