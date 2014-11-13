#!/bin/bash
 
#uncomment this for debug
#set -x

PORT="$2"
if [ "$PORT" == "" ]; then
    PORT=22
fi
if [[ "$1" =~ .+@.+ ]]; then
	user=`echo "$1" | cut -d @ -f 1`
	host=`echo "$1" | cut -d @ -f 2`
	echo "user: $user"
	echo "host: $host"
	ssh -p $PORT $1 "echo \"`cat ~/.ssh/id_rsa.pub`\" >> \$HOME/.ssh/authorized_keys"
	echo "done"
	exit 0
else
	echo "parameter should be a string like user@host port"
	exit 1
fi
