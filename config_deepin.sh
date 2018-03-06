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

# Configuration for vim
sudo apt-get install git
sudo apt-get install ctags
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ./.vimrc ~/
cp -r ./myultisnips ~/.vim
