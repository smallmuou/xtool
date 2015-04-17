#!/bin/sh
#
# Copyright (C) 2014 Wenva <lvyexuwenfa100@126.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished
# to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

set -e

VERSION=1.0.1

info() {
     local green="\033[1;32m"
     local normal="\033[0m"
     echo "[${green}INFO${normal}] $1"
}

error() {
     local red="\033[1;31m"
     local normal="\033[0m"
     echo "[${red}ERROR${normal}] $1"
}

usage() {
cat << EOF

usage: $0 [-a username:password] [-i interface] [-p ip] [-h] [-v]

DESCRIPTION:

-a      Authorization information for login. If not assign -a options, means logout.
-i      Network interface, like eth0, eth1, en0 and so on. if -p is assign, that this option is invalid.
-p      IP address for authorize or unauthorize.
-h      Display usage.
-v      Display version.

EXAMPLE:
Login:
    $0 -a username:password
    $0 -a username:password -i eth0
    $0 -a username:password -p yourip
Logout:
    $0
    $0 -p yourip

Note: For now this command only support Linux and MacOSX.
EOF
}

show_usage() {
    usage
    exit -1
}

# Main

LOGIN=0

if [ `uname` == "Darwin" ]; then
    ISMAXOSX=1
fi

# parse arguments
while getopts "a:i:p:hv" OPTION
do
    case $OPTION in
    a)
        LOGIN=1
        USERNAME=`echo $OPTARG|awk -F: '{print $1}'`
        if [ "$USERNAME" == "" ]; then
            error "Please enter username to authorize."
            show_usage
        fi

        PASSWORD=`echo $OPTARG|awk -F: '{print $2}'`
        if [ "$PASSWORD" == "" ]; then
            error "Please enter password to authorize."
            show_usage
        fi
        ;;
    p)
        IP=$OPTARG
        ;;
    i)
        INTERFACE=$OPTARG
        ;;
    h)
        show_usage
        ;;
    v)
        echo $VERSION
        exit
        ;;
    ?)        
        usage
        exit -1
        ;;
    esac
done

# if not assign ip, get default ip
if [ "$IP" == "" ]; then

    if [ "$INTERFACE" == "" ]; then
        # default interface
        if [ "$ISMAXOSX" == 1 ]; then
            INTERFACE="en0"
        else
            INTERFACE="eth0"
        fi
    fi

    if [ "$ISMAXOSX" == 1 ]; then
        IP=`ifconfig $INTERFACE|awk '/inet /{print $2}'`
    else 
        IP=`ifconfig $INTERFACE|awk '/inet /{print $2}'|awk -F: '{print $2}'`
    fi

    if [ "$IP" == "" ]; then
        error "Can't obtain ip for authorize. Please assign ip by -p."
        exit -1
    fi
fi

# Logout
if [ "$LOGIN" == 0 ]; then
    info "Trying to unauthorizing with ip $IP"
    RESPONSE=`curl -d "kind=logout&userIp=$IP" "http://192.168.9.19/smp/webauthservlet"`
    info "Send successed. For now, you need to check whether it by manual."
else #Login
    info "Trying to authorizing with username $USERNAME and ip $IP"

    # 先尝试连接一次baidu，以保证成功率
    `curl www.baidu.com > /dev/null`
    `curl -d "kind=toRedirection&urlBeforeLogin=&loginUrl=commonauth" "http://192.168.9.19/smp/webauthservlet" > /dev/null`

    RESPONSE=`curl -d "kind=preLogin&userIp=$IP&nasIp=192.168.19.2&userId=$USERNAME&password=$PASSWORD" "http://192.168.9.19/smp/webauthservlet"`
    if [ "$RESPONSE" == "" ]; then
        info "Authorize successed. Now you can access to Internet."
    else
        error "Authorize failed. Please check whether your account already login on other computer. and try again later"
    fi
fi

