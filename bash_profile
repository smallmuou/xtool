
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
alias http='python -m SimpleHTTPServer'

alias fc='cat $XTOOL/license/license-c >>'
alias fpy='cat $XTOOL/license/license-python >>'
alias fsh='cat $XTOOL/license/license-shell >>'
alias weather='curl wttr.in'

alias pj='cd ~/Projects'
alias bin='cd $XTOOL/bin'
alias md='cd ~/Markdown'
alias dt='cd ~/Desktop'

alias unrvi="udid|awk '/Serial Number/{print \$3}'|xargs rvictl -x"
alias rvi="unrvi>/dev/null;udid|awk '/Serial Number/{print \$3}'|xargs rvictl -s"

# markdown目录生成
alias mou-catalog="pbcopy < $XTOOL/res/markdown-catalog"


repeat() {
    if [ $# -le 0 ];then
        echo 'usage: repeat <count> <command>'
        return 0;
    fi

    if [ "$1" == "n" ];then
        n=100000000
    else
        n=$1    #gets the number of times the succeeding command needs to be executed
    fi
    echo $n
    shift   #now $@ has the command that needs to be executed
    while [ $(( n -= 1 )) -ge 0 ]    #loop n times;
    do
        "$@"    #execute the command; you can also add error handling here or parallelize the commands
    done
}

# $1 - username
# $2 - password
dhcp-list() {
    if [ $# -le 1 ];then
        echo "usage: dhcp-list <username> <password>"
        return 0;
    fi

    username=$1
    password=$2
    auth="Basic `echo -n $username:$password|base64`"
    gw=`netstat -rn|awk '/default/{print $2}'`

    if [ -z "`curl -s $gw|awk '/document.cookie/{print $0}'`" ];then
        result=`curl -s --header "Authorization:$auth" http://$gw/userRpm/AssignedIpAddrListRpm.htm|sed -n -e '/DHCPDynList =/,/0,0 )/p'|sed '1d;$d'|sed 'N;s/\n/ /'|sed 'N;s/\n/ /'|sed 's/"//g'|sed 's/,/ /g'`
    else
       result=`curl -s --header "Cookie:Authorization=$auth" http://$gw/userRpm/AssignedIpAddrListRpm.htm|sed -n -e '/DHCPDynList =/,/0,0 )/p'|sed '1d;$d' |sed 's/"//g'|sed 's/,/ /g'`
    fi

    if [ -z "$result" ];then
        echo 'Please check the username and password.'
    else 
        echo "${result}"|awk '{printf $4"\t"$3"\t"$2"\t"$1"\n"}'
    fi
}


