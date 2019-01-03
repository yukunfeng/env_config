# For linux maps cpas lock to ctrl
# in /etc/default/keyboard add XKBOPTIONS="ctrl:nocaps"

# Set local path probably used in future
export LD_LIBRARY_PATH="$HOME/local/lib/:$LD_LIBRARY_PATH"
export PATH="$HOME/local/bin:$PATH"

# Path to your oh-my-zsh installation.
# sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="refined"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="avit"
# ZSH_THEME="agnoster"
DEFAULT_USER="$USER"
# ZSH_THEME="ys"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom/


# Install plugins manually

# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ] ; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
fi

if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ] ; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
fi

#
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  z
  extract
  history-substring-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# configuration for plugins

# Set shell command line to be vim-like
set -o vi

# Comment this will cause unseen completion due to same background color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
# ctrl + f to accept suggestions
bindkey '^F' autosuggest-accept
bindkey "^?" backward-delete-char

# Eanble fuzzy search
HISTORY_SUBSTRING_SEARCH_FUZZY='whateveryouwant'


# Fix vim tab error
# rm -rf ~/.antigen/.zcomp*
# rm -rf $ZSH_COMPDUMP


# User configuration
#
# Super useful fuzzy completion
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

# To check the os name of current shell
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     MY_MACHINE_TYPE=Linux;;
    Darwin*)    MY_MACHINE_TYPE=Mac;;
    CYGWIN*)    MY_MACHINE_TYPE=Cygwin;;
    MINGW*)     MY_MACHINE_TYPE=MinGw;;
    *)          MY_MACHINE_TYPE="UNKNOWN:${unameOut}"
esac
export MY_MACHINE_TYPE=$MY_MACHINE_TYPE


# Restore incremental search
# bindkey -v
# bindkey '^R' history-incremental-search-backward

# Set LANG
# zh_CN.GBK for Chinese
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

# Set for macos
# coloring output from ls for mac
if [ "$MY_MACHINE_TYPE" = "Mac" ]; then
    # brew install coreutils at first
    # Or simply use following line if gls is not available
    # export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
    alias l='gls -htl --color=auto'
    alias ll='l'
    alias ls='gls --color=auto'
    alias ccc='pbcopy'
    alias vvv='pbpaste'
    alias shuf='gshuf'
else
    # Alias the command for linux
    alias l='ls -lht --color=auto'
    alias ll='l'
    alias ccc='xclip -selection clipboard'
    alias vvv='xclip -selection clipboard -o'
    alias open='gnome-open'
fi

# Setting for pyenv
if [ -e "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
        # Setting python version
        pyenv shell anaconda3-5.1.0
        # pyenv shell 3.6.5
        # pyenv shell 2.7.15
     fi
fi

# Export cuda related lib if it exists
if [ -e "/usr/local/cuda" ]; then
    ## CUDA and cuDNN paths
    export PATH=/usr/local/cuda/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
    export CUDA_PATH=/usr/local/cuda

    #cudnn
    export CFLAGS=-I/usr/local/cudnn/include
    export LDFLAGS=-L/usr/local/cudnn/lib64
    export LD_LIBRARY_PATH=/usr/local/cudnn/lib64:$LD_LIBRARY_PATH
fi

# Set for CCProxy for server unable to acess Internet
# outer_ip=10.130.14.95:808
# export http_proxy=$outer_ip
# export https_proxy=$outer_ip

# Useful records
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Set the color for ls

colors_dir="${HOME}/.dircolors"
color_file="dircolors.ansi-dark"
if [ -d "$colors_dir" ] ; then
    if [ "$MY_MACHINE_TYPE" = "Mac" ]; then
        eval `gdircolors ${colors_dir}/${color_file}`
    else
        eval `dircolors ${colors_dir}/${color_file}`
    fi

else
    # Create dir and download dircolors
    mkdir ${colors_dir}
    git clone https://github.com/seebi/dircolors-solarized.git ${colors_dir}
    eval `dircolors ${colors_dir}/${color_file}`
    eval `gdircolors ${colors_dir}/${color_file}`
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

# clear latex non-used files
latex_clear () {
    array=("log" "pdf" "toc" "nav" "out" "aux" "snm" "vrb" "bbl" "blg")
    for element in "${array[@]}"
    do
        rm -f $1.$element
    done
    rm -f texput.log
}

# generate pdf file with updated bib file
biblatex () {
    basefile=$1
    latex_clear 
    pdflatex $basefile
    bibtex $basefile
    pdflatex $basefile
    pdflatex $basefile
}

if [ "$MY_MACHINE_TYPE" = "Mac" ]; then
    # Get scp parameter
    getscp () {
        echo $USER@$(ipconfig getifaddr en1):$(pwd)/$1
    }

    # remote copy (rcopy)
    rcopy () {
        # $SSH_CLIENT or $SSH_CONNECTION
        ssh fengyukun@$(echo $SSH_CLIENT | perl -lane 'print $F[0]') 'pbcopy'
    }

else
    getscp () {
        echo $USER@$(hostname -I | perl -lane 'print $F[0]'):$(readlink -f $1)
    }

    # remote copy (rcopy)
    rcopy () {
        ssh fengyukun@$(echo $SSH_CLIENT | perl -lane 'print $F[0]') 'xclip -selection clipboard'
    }
fi

# https://stackoverflow.com/questions/42848130/why-i-cant-access-remote-jupyter-notebook-server
jupyter_server() {
    jupyter notebook --no-browser --ip $(hostname -I | perl -lane 'print $F[0]') --port 8333
}
