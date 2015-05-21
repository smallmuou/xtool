#!/bin/sh

# Copyright (C) 2014 Wenva <lvyexuwenfa100@126.com>
 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished
# to do so, subject to the following conditions:
 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

set -e

VERSION=1.0.0
PACKAGE=""
OUTPUT=~

usage() {
cat << EOF
usage: $0 [-h] [-v] [-o output] project

OPTIONS
   -h       Display usage
   -v       Display version information
   -o       Set output directory
EOF
}

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

spushd()
{
     pushd "$1" 2>&1> /dev/null
}

spopd()
{
     popd 2>&1> /dev/null
}

# buildprepare source_path build_path
buildprepare(){
	info "PREPARING BUILD"
	rm -rf "$2"
	mkdir -p "$2"
	cp -rf "$1"/* "$2"
	find "$2" -name ".svn" -exec rm -r {} \;
}

buildxcodeproj() {
    info "BUILDING $1.xcodeproj"

    xcodebuild
}

filterbuild() {
	if ! [ -e "build/Release-iphoneos/"$1".app" ]; then
		error "build/Release-iphoneos/"$1".app doesn't exist. Please rebuild project"
		return -1
	fi

	info "FILTERING BUILD"
	rm -rf build/Release-iphoneos/"$1".app/_CodeSignature
	rm -rf build/Release-iphoneos/"$1".app/*.lproj
	rm -rf build/Release-iphoneos/"$1".app/Info.plist
	rm -rf build/Release-iphoneos/"$1".app/*.mobileprovision
	rm -rf build/Release-iphoneos/"$1".app/ResourceRules.plist
}

filtersource() {
	info "FILTERING SOURCE"

	rm -rf .tmp
	mkdir .tmp
	cp -rf "$1"/*Info.plist .tmp/
	cp -rf "$1"/*.lproj .tmp/
	rm -rf "$1"/*
	mv .tmp/* "$1"/
	rm -rf .tmp
}

regroup() {
	info "REGROUPING"
	mv build/Release-iphoneos/"$1".app "$1"/build
	rm -rf build
}

while getopts "hvo:" OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         v)
             echo $VERSION
             exit 1
             ;;
         o)
			OUTPUT=$OPTARG
			 ;;
         ?)
			echo $OPTAGE
             usage
             exit 1
             ;;
     esac
done
shift $(($OPTIND - 1))

PACKAGE="$1"

if [ "$PACKAGE" == "" ]; then 
	usage
	exit -1
fi

SOURCE=`pwd`
BUILD="$OUTPUT"/"$PACKAGE"_build

if ! [ -e "$PACKAGE.xcodeproj" ]; then
	error "$PACKAGE.xcodeproj doesn't exist. Please enter the project directory"
	exit -1
fi

buildprepare "$SOURCE" "$BUILD"

spushd $BUILD
buildxcodeproj "$PACKAGE"
filterbuild "$PACKAGE"
filtersource "$PACKAGE"
regroup "$PACKAGE"
open "$PACKAGE".xcodeproj
spopd

info "BUILD COMPLETED"
