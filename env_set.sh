#!/usr/bin/env bash

# Author: Feng Yukun
# Brief: Set linux shell environment


# Alias the command
alias l='ls -lht'

# Set shell command line to be vim-like
set -o vi

# Set local path probably used in future
# export LD_LIBRARY_PATH="$HOME/local/lib/"
# export PATH="$HOME/local/bin:$PATH"

# Set for CCProxy for server unable to acess Internet
# outer_ip=10.130.14.95:808
# export http_proxy=$outer_ip
# export https_proxy=$outer_ip

# Set the color for ls

colors_dir="${HOME}/.${USER}_dircolors"
color_file="dircolors.ansi-dark"
if [ -d "$colors_dir" ] ; then
    eval `dircolors ${colors_dir}/${color_file}`
else
    # Create dir and download dircolors
    mkdir ${colors_dir}
    git clone https://github.com/seebi/dircolors-solarized.git ${colors_dir}
    eval `dircolors ${colors_dir}/${color_file}`
fi

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

# Check whether a port is in use
function cport() {
    port=$1
    lsof -i -P -n | grep $port 
}

# Get scp parameter
getscp () {
    echo $USER@$(hostname -I | perl -lane 'print $F[0]'):$(readlink -f $1)
}

# make()
# {
  # pathpat="(/[^/]*)+:[0-9]+"
  # ccred=$(echo -e "\033[0;31m")
  # ccyellow=$(echo -e "\033[0;33m")
  # ccend=$(echo -e "\033[0m")
  # /usr/bin/make "$@" 2>&1 | sed -r -e "/[Ee]rror[: ]/ s%$pathpat%$ccred&$ccend%g" -e "/[Ww]arning[: ]/ s%$pathpat%$ccyellow&$ccend%g"
  # return ${PIPESTATUS[0]}
# }

