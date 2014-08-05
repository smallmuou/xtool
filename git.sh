#!/bin/sh

NEEDINIT=FALSE
TARGET=

NEEDCOMMIT=FALSE
COMMENTS=

#Parse argument
while getopts "m:i" opt; do
    case $opt in
        i)  NEEDINIT=TRUE
            ;;
        m)  NEEDCOMMIT=TRUE
            COMMENTS=$OPTARG
            ;;
        \?) echo "Usage:./git.sh -i 'Repo' -m 'Comments'"
            ;;
    esac
done

#Init
if ( $NEEDINIT ) then
    TARGET=$(basename $(pwd))
    git init
    git add .
    git remote rm origin
    echo "git@github.com:smallmuou/$TARGET.git"
    git remote add origin git@github.com:smallmuou/$TARGET.git
fi

#Commit
if ( $NEEDCOMMIT ) then
    git commit -m $COMMENTS
    git push origin master
fi

