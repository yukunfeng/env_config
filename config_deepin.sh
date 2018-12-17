#!/bin/sh

# ----------------------------------------------------------------------
# Author:	Yukun Feng
# Date:	03-06-18
# Email:	yukunfg@gmail.com
# Description:	 Configure deepin environment
# ----------------------------------------------------------------------

# Install lua and python library
apt-get install lua5.3 lua5.3-dev python3-dev

# link lua headers and lib
sudo ln -sf /usr/lib/x86_64-linux-gnu/liblua5.3.so /usr/lib/liblua.so
sudo ln -sf /usr/include/lua5.3/ /usr/include/lua

# Compiling vim from source code with lua and python support
wget ftp://ftp.vim.org/pub/vim/unix/vim-8.0.tar.bz2
sudo ./configure --enable-python3interp --with-python-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/ --enable-luainterp --with-lua-prefix=/usr/

/home/lr/$HOME/.pyenv/versions/3.5.0
linux
./configure --enable-python3interp --with-python-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/ --enable-luainterp --with-lua-prefix=$HOME/local --prefix=$HOME/local

on mac:
brew reinstall vim --with-lua --with-override-system-vi --with-python3

install vim through anaconda
https://gist.github.com/hxhc/778d7c3a3ad491dedf3675a47275a979
--enable-pythoninterp
--with-python-config-dir=/usr/lib/python2.6/config'


anaconda (for this part, install anaconda at first)
./configure --enable-python3interp --with-python-config-dir=$HOME/.pyenv/versions/3.5.0 --enable-luainterp --with-lua-prefix=$HOME/local --prefix=$HOME/local

./configure --enable-python3interp --with-python-config-dir=HOME/.pyenv/versions/anaconda3-5.0.0/lib/python3.6/config-3.6m-x86_64-linux-gnu/ --enable-luainterp --with-lua-prefix=$HOME/local --prefix=$HOME/local

HOME/.pyenv/versions/anaconda3-5.0.0/lib/python3.6/config-3.6m-x86_64-linux-gnu/

install vim through conda. The following vim is compiled with python support but not with lua support
https://anaconda.org/bardminz
conda install -c bardminz vim


Inside vim source:
make distclean: cleaning
make uninstall: cleanning target directory

# Configuration for vim
sudo apt-get install git
sudo apt-get install ctags
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ./.vimrc ~/
cp -r ./myultisnips ~/.vim
