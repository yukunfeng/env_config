#!/bin/sh

# ----------------------------------------------------------------------
# Author:	Yukun Feng
# Date:	05-11-18
# Email:	yukunfg@gmail.com
# Description:	 Copy .vimrc, .zshrc and snippts to home
# ----------------------------------------------------------------------

set -x


cp -r myultisnips $HOME/.vim
cp .vimrc .zshrc .tmux.conf $HOME
cp ./refined.zsh-theme $HOME/.oh-my-zsh/custom/themes
cp ./auto-pairs.vim $HOME/.vim/plugged/auto-pairs/plugin

# setting for indent (avoid overriding by other plugins)
after_plugin_dir="$HOME/.vim/after/ftplugin/"
mkdir -p "$after_plugin_dir"
cp ./python.vim $after_plugin_dir
