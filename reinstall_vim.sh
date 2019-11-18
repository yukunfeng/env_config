#!/bin/sh

# Note
# If root is available, but hard to compile even with correct options, try compile locally
# utisnips recently has some bugs. After downloading it, go back to a certain tag:
# git reset --hard tagname (use 3.1)
# Following is how to locally compile. For re-complie with root, see gist in my github
# if python3 has some problems, try python2 and remmber set ultisnips to tag 3.1

# re-install vim with python and lua support. (this is for some plugins in vim)

# makdir softwares

# first step: download lua source code
mkdir -p $HOME/local    # the source code will be installed in this target directory
wget https://www.lua.org/ftp/lua-5.3.5.tar.gz   # download lua source code
tar zxf lua-5.3.5.tar.gz  # extract tar.gz file

# then go into this extraced directory and change the target directory (INSTALL_TOP) in Makefile
# from
# INSTALL_TOP= /usr/local
# to
# INSTALL_TOP= $(HOME)/local
# and then make; make install


# second step: reinstall vim with lua and python support
# download vim
wget ftp://ftp.vim.org/pub/vim/unix/vim-8.0.tar.bz2
tar xaf vim-8.0.tar.bz2


# compile
# check whether python config is correct or not
./configure --enable-python3interp --with-python-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/ --enable-luainterp --with-lua-prefix=$HOME/local --prefix=$HOME/local

# in here, download mac font for powerline for vim. Just click to install
# https://gist.github.com/baopham/1838072

# for mac
# brew install coreutils
