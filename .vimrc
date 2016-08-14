
""""""""""" common setting """""""""""""""

set nocompatible              " nocompatible with vi. This means Vim will use Vim defaults
set t_Co=256               " set the number of colors. This setting will be used for some plugins
set number              " always show the line number
set mouse=v             " enable the mouse. this allows the mouse copy the content of the screen
set cursorline              " highlight the screen line of the cursor
set hlsearch              " hight the search result
set nofoldenable              " no folding when opening a file
set foldmethod=indent          " set the fold method
" use space to turn on/off the fold at current line
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
set autoindent        " copy indent from current line when starting a new line
set smartindent

" encoding set
set encoding=utf-8
" seting for baidu-speech linux server (files encoded with gbk are often used,
" but vim ofen detect it wrongly)
nnoremap <F7> :e ++enc=gbk<CR>

" dictionary word completion using ctrl-x ctrl-k
set dictionary+=/usr/share/dict/words
imap <c-k> <c-x><c-k>

" the best explanation about tab in vim I have seen is http://tedlogan.com/techblog3.html
set expandtab        " in Insert mode: Use the appropriate number of spaces to insert a <Tab>.
set tabstop=4        " number of spaces that a <Tab> in the file counts for
set shiftwidth=4     " number of spaces to use for each step of (auto)indent
set softtabstop=4	" number of spaces that a <Tab> counts for while performing editing operations

set ignorecase
set smartcase   " override the 'ignorecase' option if the search pattern contains upper case characters

" insert timestamp (now inserting the timestamp can be dong by Ultisnips)
"nnoremap <F5> i<C-R>=strftime("%Y-%m-%d")<Return><Esc>
"inoremap <F5> <C-R>=strftime("%Y-%m-%d")<Return>

" remove all trailing whitespace by pressing F6
nnoremap <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:noh<CR>

" 79 column layout concerns
"set colorcolumn=79    " this will display a column at 79
set colorcolumn=99    " this will display a column at 99. This setting is for baidu speech server
" au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)    " this will high light when a column exceeds 80

" short cut for change windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j       " nerd tree has mapped it, so when in nerd tree window, this short cut will not work
noremap <C-k> <C-w>k       " nerd tree has mapped it, so when in nerd tree window, this short cut will not work
noremap <C-l> <C-w>l

" let vim jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

""""""""""" plugin setting """""""""""""""

""" setting for vundle

filetype off                  " not detect the file type required for Vundle plugin
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required for Vundle plugin
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-powerline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'taglist.vim'
Plugin 'majutsushi/tagbar'      " better support than taglist for object oriented
Plugin 'Yggdroot/indentLine'
" YouCompleteMe is a plugin with a compiled component. So read the doc about how to install it correctly
Plugin 'Valloric/YouCompleteMe'
"Plugin 'Shougo/neocomplete'
Plugin 'tpope/vim-surround'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
" filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on

""" setting for solarized
syntax enable
"set background=light     " solarized color has two theme: dark and light
set background=dark     " solarized color has two theme: dark and light
colorscheme solarized

""" setting for powerline
set laststatus=2   " Always show the statusline
let g:Powerline_theme = 'default'
if &background=='light'
    let g:Powerline_colorscheme = 'solarized'
else
    let g:Powerline_colorscheme = 'default'
endif

""" setting for nerd tree
nnoremap <F2> :NERDTreeToggle<Return>    " make a short cut for nerd tree
let g:NERDTreeDirArrowExpandable = '>'    " customize arrow for nerd tree
let g:NERDTreeDirArrowCollapsible = '-'

""" setting for nerd commenter
" short cut for comment, see more about nerd comment by :help
noremap ,m :call NERDComment(1, 'minimal')<Return>
noremap ,i :call NERDComment(1, 'invert')<Return>
noremap ,s :call NERDComment(1, 'sexy')<Return>
noremap ,u :call NERDComment(1, 'uncomment')<Return>
"let NERDSpaceDelims = 1        " leave a space after commentering

""" setting for auto pairs
" to insert one pair purely, use use Ctrl-V + pair

""" setting for tag list
noremap tl :TlistToggle<Return>
let Tlist_Use_Right_Window=1    " tag list window on the right(0 on the left)
let Tlist_WinWidth=30        " the width of tag list window
let Tlist_Exit_OnlyWindow=1     " quit if only list tag window left
let Tlist_File_Fold_Auto_Close=1    " auto fold

""" setting for indentLine
let g:indentLine_char = '┊'

""" setting for tag bar
noremap tb :TagbarToggle<Return>
"let g:tagbar_width=30   " width of tagbar
let g:tagbar_width=50   " width of tagbar for wide screen in baidu speech
let g:tagbar_left=0     " tagbar window on the left(1 on the right)
let g:tagbar_sort = 0   " tags are sorted according to their order in the source file
let g:tagbar_show_linenumbers = 1

""" setting for YouCompleteMe
noremap <F3> :YcmCompleter GetDoc<Return> " short cut for get document
noremap <F4> :YcmCompleter GoToDeclaration<Return> " short cut for go to declaration

""" setting for tags
set tags=./tags,tags;/

" setting for ultisnips
" Trigger configuration. Do not use <tab> if you use " https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger=",e"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["myultisnips", "UltiSnips"]


" setting for cscope. Parts of the script come from http://cscope.sourceforge.net/cscope_maps.vim
if has("cscope")
    " look for cscope file everywhere starting from the current directory up to the root.
    function! LoadCscope()
        let db = findfile("cscope.out", ".;")
        if (!empty(db))
            let path = strpart(db, 0, match(db, "/cscope.out$"))
            set nocscopeverbose " suppress 'duplicate connection' error
            exe "cs add " . db . " " . path
            set cscopeverbose
        endif
    endfunction
    au BufEnter /* call LoadCscope()

    nmap ,fs :cs find s <C-R>=expand("<cword>")<CR><CR> " 's' symbol: find all references to the token under cursor
    nmap ,fg :cs find g <C-R>=expand("<cword>")<CR><CR> " 'g' global: find global definition(s) of the token under cursor
    nmap ,fc :cs find c <C-R>=expand("<cword>")<CR><CR> " 'c' calls:  find all calls to the function name under cursor
    nmap ,ft :cs find t <C-R>=expand("<cword>")<CR><CR> " 't' text:   find all instances of the text under cursor
    nmap ,fe :cs find e <C-R>=expand("<cword>")<CR><CR> " 'e' egrep:  egrep search for the word under cursor
    nmap ,ff :cs find f <C-R>=expand("<cfile>")<CR><CR> " 'f' file:   open the filename under cursor
    nmap ,fi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR> " 'i' includes: find files that include the filename under cursor
    nmap ,fd :cs find d <C-R>=expand("<cword>")<CR><CR> " 'd' called: find functions that function under cursor calls

endif

