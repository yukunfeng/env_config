#!/usr/bin/env bash

# Author: Feng Yukun
# Brief: Commands usage habits


# Alias the command

alias l='ls -lh'
# Use \rm or /bin/rm to excute real rm instead of alias stuff
alias srm='safe_rm'
alias cpep='convenient_pep8'

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

# Make the trash

trash_dir="${HOME}/.${USER}_trash"
if [ -d "${trash_dir}" ] ; then
    nothing='a'
else
    # Create trash dir
    mkdir ${trash_dir}
fi

# Function

# My rm operation which is a much safer way
safe_rm () {
    mv --backup=t $* ${trash_dir}
}

# Convenient pep8 to check python scripts
convenient_pep8 () {
    pep8 --show-source $1 | less -N
}

# Wipe out the trash and colors
wipe_out () {
    \rm ${trash_dir} -rf
    \rm ${colors_dir} -rf
}

# Generate URL for networking command (e.g., wget, scp) on the current working directory
genurl () {
    url="$USER@$(hostname):$(pwd)/$(basename "$1")"
    echo $url
}

# Create the cscope database in a specific directory
csdb() {
    cd $1
    find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files
    cscope -bq
}
