# XTool
该工具集合了VIM、常用命令，用于MacOSX和Linux环境构建.

## Dependences
在执行install之前，需要安装如下依赖:

* brew － mac安装工具，类似ubuntu的apt-get

<pre>
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"</pre>
	
* ctags - vim的代码阅读

<pre>	
wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
tar -zxvf ctags-5.8.tar.gz
cd ctags-5.8
./configure
make
sudo make install</pre>

* cscope - vim的代码阅读
<pre>sudo brew install cscope

或者

wget https://downloads.sourceforge.net/project/cscope/cscope/15.8a/cscope-15.8a.tar.gz 
./configure
make
sudo make install</pre>
	

## Install
* cd xtool
* sh install.sh
* vim -> Bundle Install