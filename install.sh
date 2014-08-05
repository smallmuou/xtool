#/bin/sh

CUR_DIR=$(pwd)
BASH_PROFILE=$HOME/.bash_profile

function isMacOS() 
{
    if [ "Darwin"=$(uname -s) ];then 
        return 1
    else 
        return 0
    fi
}

# create link
rm -rf $HOME/.vimrc
rm -rf $HOME/.vim
ln -s $CUR_DIR/vimrc $HOME/.vimrc
ln -s $CUR_DIR/vim $HOME/.vim

# import tag to .bash_profile
tag="alias tag='$CUR_DIR/gen_tag.sh'"
untag="alias untag='find ./ -name \"tags\" -o -name \"cscope.*\"|xargs rm'"
ipa="alias ipa='$CUR_DIR/gen_ipa.sh'"
git="alias gg='$CUR_DIR/git.sh'"

# MacOS Preferences
if [ $(isMacOS)=1 ]; then
echo 'export CLICOLOR=1' >> $BASH_PROFILE
echo 'export LSCOLORS=gxfxaxdxcxegedabagacad' >> $BASH_PROFILE
fi

echo '#tag generate & clear; For read source code' >> $BASH_PROFILE
echo $tag >> $BASH_PROFILE
echo $untag >> $BASH_PROFILE
echo $ipa >> $BASH_PROFILE
echo $git >> $BASH_PROFILE

source $BASH_PROFILE


