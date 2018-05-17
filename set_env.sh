#!/bin/sh

# ----------------------------------------------------------------------
# Author:	Yukun Feng
# Date:	05-11-18
# Email:	yukunfg@gmail.com
# Description:	 Copy .vimrc, .zshrc and snippts to home
# ----------------------------------------------------------------------

cp -r myultisnips $HOME/.vim
cp .vimrc .zshrc $HOME
