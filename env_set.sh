#!/usr/bin/env bash

# Author: Yukun Feng
# Brief: Set linux shell environment


# Alias the command
alias l='ls -lht'

# Set shell command line to be vim-like
set -o vi

# Set LANG
# export LANG=zh_CN.GBK

# Set local path probably used in future
# export LD_LIBRARY_PATH="$HOME/local/lib/:$LD_LIBRARY_PATH"
# export PATH="$HOME/local/bin:$PATH"

# Set for CCProxy for server unable to acess Internet
# outer_ip=10.130.14.95:808
# export http_proxy=$outer_ip
# export https_proxy=$outer_ip

# Useful records
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Set the color for ls

# colors_dir="${HOME}/.${USER}_dircolors"
# color_file="dircolors.ansi-dark"
# if [ -d "$colors_dir" ] ; then
   # eval `dircolors ${colors_dir}/${color_file}`
# else
    # Create dir and download dircolors
   # mkdir ${colors_dir}
   # git clone https://github.com/seebi/dircolors-solarized.git ${colors_dir}
   # eval `dircolors ${colors_dir}/${color_file}`
# fi

# Function

# Convenient pep8 to check python scripts
convenient_pep8 () {
    pep8 --show-source $1 | less -N
}

# Count ngram from arpa LM
function cngram() {
    if (( $# < 1 )); then 
        echo "usage: cngram arpa_file [...]"
        echo ""
        return 1
    fi
    for i in "$@"; do
        echo -n "$i: "
        head $i | perl -lne 'BEGIN {$total=0.0}; if ($_ =~/=(\d+)/) {$total += int($1)};END{print $total/1e6." million"}'
    done
}

# Get scp parameter
getscp () {
    echo $USER@$(hostname -I | perl -lane 'print $F[0]'):$(readlink -f $1)
}
