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
    if [ $# != 1 ]; then
        echo "Paramters error"
    fi
    current_file_path=$1
    file_basename=$(basename $current_file_path)
    file_trash_path="$trash_dir/$file_basename"
    if [ -e "$file_trash_path" ]; then
        rm -rf $file_trash_path
    fi
    mv $current_file_path ${trash_dir}
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

# make()
# {
  # pathpat="(/[^/]*)+:[0-9]+"
  # ccred=$(echo -e "\033[0;31m")
  # ccyellow=$(echo -e "\033[0;33m")
  # ccend=$(echo -e "\033[0m")
  # /usr/bin/make "$@" 2>&1 | sed -r -e "/[Ee]rror[: ]/ s%$pathpat%$ccred&$ccend%g" -e "/[Ww]arning[: ]/ s%$pathpat%$ccyellow&$ccend%g"
  # return ${PIPESTATUS[0]}
# }

