#!/bin/sh
cur_dir=$(pwd)

find $cur_dir -type f -name "*.[ch]"> cscope.files
cscope -Rbkq -i cscope.files
find $cur_dir/ -name "*.h" -o -name "*.c" -o -name "*.cpp" | xargs ctags
