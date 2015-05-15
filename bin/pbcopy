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


base_url="http://yuedu.fm"

function rand() {
    min=$1  
    max=$(($2-$min+1))  
    num=$(($RANDOM+1000000000))
    echo $(($num%$max+$min))  
}

function get_url() {
    uri=`curl $base_url/article/$1/ | awk -F: '/mp3:/{print $2}'| sed 's/\"//g'`
    echo "$base_url$uri"
}

`pkill mplayer`

while true
do

on=`ps|awk '/mplayer/{print $0}'|grep mp3`

if [ -z "$on" ]; then
    url=$(get_url $(rand 1 1000))
    echo "Play:$url"
    `mplayer $url`&
fi

sleep 10

done


