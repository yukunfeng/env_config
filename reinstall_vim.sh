#!/bin/sh

# re-install vim with python and lua support. (this is for some plugins in vim)

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
