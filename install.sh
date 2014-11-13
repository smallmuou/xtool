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

FIRST_INSTALL=$HOME/.first_xtool
DIRNAME=$(dirname $0)
BASH_PROFILE=$HOME/.bash_profile
CUR_PATH=`pwd`

# check whether run in xtool directory
if [ "$DIRNAME" != "." ] && [ "$DIRNAME" != ""  ]; then
	echo "Please run me in xtool root directory."
fi

# check whether first install
if [ -e	"$FIRST_INSTALL"  ]; then
	echo "The xtool is already installed."
	exit -1
fi

# ----------------------- main -------------------------------
git submodule update --init --recursive

# vim link
rm -rf $HOME/.vimrc
rm -rf $HOME/.vim
ln -s $CUR_PATH/vimrc $HOME/.vimrc
ln -s $CUR_PATH/vim $HOME/.vim

# write to bash profile
echo "export XTOOL=$CUR_PATH" >> $BASH_PROFILE
echo ". $CUR_PATH/bash_profile" >> $BASH_PROFILE
touch $FIRST_INSTALL
source $BASH_PROFILE
