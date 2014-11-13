#!/bin/bash

echo -e "\033[31mNote:Disable Zombie Objects \033[0m"

if [ $# -ne 2 ]; then 
	echo Usage:$0 project.app app.ipa
	exit 0
fi

APP_PATH=$1
IPA_NAME=$2
DST_PATH=./Payload/
CUR_PATH=`pwd`

#app path
if [ ${APP_PATH:0:1} != "/" ]; then
	APP_PATH=$CUR_PATH/$APP_PATH
fi

#check app path
if [ ! -e "$APP_PATH" ]; then
	echo "$APP_PATH does't exist!"
	exit 0
fi

echo 'start processing...'
rm -rf $DST_PATH
mkdir -p $DST_PATH

#copy and zip
cp -rf "$APP_PATH" "$DST_PATH"
zip -r "$IPA_NAME" "$DST_PATH"

rm -rf "$DST_PATH"
echo 'successed!'

