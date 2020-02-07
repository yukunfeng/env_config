
""""""""""" common setting """""""""""""""

set foldlevel=99    " https://stackoverflow.com/questions/5784677/the-first-time-i-close-a-fold-it-closes-all-folds"
" Fix backspace problem
set backspace=indent,eol,start
set nocompatible              " nocompatible with vi. This means Vim will use Vim defaults
set t_Co=256               " set the number of colors. This setting will be used for some plugins
set number              " always show the line number
set mouse=v             " enable the mouse. this allows the mouse copy the content of the screen
set cursorline              " highlight the screen line of the cursor
" set cursorcolumn
nnoremap <F3> :set nocursorline<CR>
set hlsearch              " hight the search result
set nofoldenable              " no folding when opening a file
set foldmethod=indent          " set the fold method
" use space to turn on/off the fold at current line
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
set autoindent        " copy indent from current line when starting a new line
set smartindent

" hidden showing feature in markdown or latex files
" verbose set conceallevel to check which plugin change this value last
set conceallevel=0

" show line number and column number
set ruler
" Disable syntax hightlighting for speeding up vim
set synmaxcol=120
" disable case-sensitive in command-line mode
set wildignorecase

" encoding set
set encoding=utf-8
set termencoding=utf-8
" seting for baidu-speech linux server (files encoded with gbk are often used,
" but vim ofen detect it wrongly)
nnoremap <F7> :e ++enc=gbk<CR>
" Prevent that vim jumps to the next match when pressing *
nnoremap * *``

" dictionary word completion using ctrl-x ctrl-k
set dictionary+=/usr/share/dict/words
imap <c-k> <c-x><c-k>

" the best explanation about tab in vim I have seen is http://tedlogan.com/techblog3.html
" set expandtab        " in Insert mode: Use the appropriate number of spaces to insert a <Tab>.
" set tabstop=4        " number of spaces that a <Tab> in the file counts for
" set shiftwidth=4     " number of spaces to use for each step of (auto)indent
" set softtabstop=4	" number of spaces that a <Tab> counts for while performing editing operations

set ignorecase
set smartcase   " override the 'ignorecase' option if the search pattern contains upper case characters

set noundofile  " stop vim from creating a "un~" file.

autocmd FileType python map <buffer> <F6> :call Flake8()<CR>
" insert timestamp (now inserting the timestamp can be done by Ultisnips)
"nnoremap <F5> i<C-R>=strftime("%Y-%m-%d")<Return><Esc>
"inoremap <F5> <C-R>=strftime("%Y-%m-%d")<Return>

" remove all trailing whitespace by pressing F6
" nnoremap <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:noh<CR>

" 79 column layout concerns
let column_limit=79
let &colorcolumn=column_limit   " a vertical line will appear at column_limit

" setting for word wrapping, see http://vim.wikia.com/wiki/Automatic_word_wrapping
set fo+=t
set fo-=l
let &tw=column_limit     " automatic word wrapping at column_limit. Set 0 to stop wrapping
" gq to wrap selected lines, gqq wraps the current line and gqip wraps current paragraph
" au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)    " this will high light when a column exceeds 80
noremap <F9> :set wrap!<CR>
" autowrap is excluded in shell script
autocmd BufNewFile,BufRead *.sh set tw=0

set nowrap

" set spell for latex
autocmd FileType tex set spell
autocmd FileType latex set spell


" map for tabs
noremap <F10> :tabn<CR>

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

" filetype off                  " not detect the file type required for Vundle plugin
" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" let Vundle manage Vundle, required for Vundle plugin
" Plugin 'VundleVim/Vundle.vim'

" for junegunn/vim-plug
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" colorscheme
Plug 'altercation/vim-colors-solarized'
Plug 'KeitaNakamura/neodark.vim'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'

Plug 'vim-python/python-syntax'
Plug 'vim-scripts/a.vim'
" Plug 'Lokaltog/vim-powerline'
" Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
" Plug 'taglist.vim'
Plug 'majutsushi/tagbar'      " better support than taglist for object oriented
Plug 'Yggdroot/indentLine'
" YouCompleteMe is a plugin with a compiled component. So read the doc about how to install it correctly
"Plug 'Valloric/YouCompleteMe'
Plug 'Shougo/neocomplete'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/incsearch.vim'
" Plug 'nvie/vim-flake8'
" Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
Plug 'lervag/vimtex'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'FooSoft/vim-argwrap'
Plug 'christoomey/vim-titlecase'
Plug 'rhysd/vim-grammarous'
" Plug 'davidhalter/jedi-vim'
" Plug 'tell-k/vim-autopep8'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'


" Initialize plugin system
call plug#end()

" All of your Plugins must be added before the following line for vundle
" call vundle#end()            " required

" filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on

syntax enable
set termguicolors
" see https://www.reddit.com/r/vim/comments/5416d0/true_colors_in_vim_under_tmux/
" for why following two lines are added (short for tmux usage)
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
" set background=light
colorscheme neodark
" colorscheme solarized
" colorscheme gruvbox

" setting for fzf
" Open files in vertical horizontal split
" nnoremap <silent> <Leader>v :call fzf#run({
nnoremap <silent> qv :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>

" fuzzy file path completion
inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({'dir': expand('%:p:h')}))

""" setting for status line
" set laststatus=0   " Always show the statusline
set laststatus=2   " Always show the statusline
let g:airline_theme='neodark'
" let g:airline_theme='solarized'
" let g:airline_solarized_bg='dark'
" use powerline fonts
let g:airline_powerline_fonts = 1
" file encoding section
let g:airline_section_y = ''
" mode section
let g:airline_section_a = ''

" let g:Powerline_theme = 'default'
" if &background=='light'
    " let g:Powerline_colorscheme = 'solarized'
" else
    " let g:Powerline_colorscheme = 'default'
" endif

""" setting for nerd tree
" nnoremap <F2> :NERDTreeToggle<Return>    " make a short cut for nerd tree
nnoremap <F2> :NERDTree %<Return>    " open from current file's directory
let g:NERDTreeDirArrowExpandable = '>'    " customize arrow for nerd tree
let g:NERDTreeDirArrowCollapsible = '-'

" setting for python syntax hightlighting
let g:python_highlight_all = 1

""" setting for nerd commenter
" short cut for comment, see more about nerd comment by :help
noremap ,m :call NERDComment(1, 'minimal')<Return>
noremap ,i :call NERDComment(1, 'invert')<Return>
noremap ,s :call NERDComment(1, 'sexy')<Return>
noremap ,u :call NERDComment(1, 'uncomment')<Return>
let NERDSpaceDelims = 1        " leave a space after commentering

" setting for ale
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
" let g:ale_cache_executable_check_failures = 1
" let g:ale_linters = {
" \   'python': ['pylint'],
" \}

""" setting for auto pairs
" to insert one pair purely, use use Ctrl-V + pair

""" setting for tag list
noremap tl :TlistToggle<Return>
let Tlist_Use_Right_Window=1    " tag list window on the right(0 on the left)
let Tlist_WinWidth=30        " the width of tag list window
let Tlist_Exit_OnlyWindow=1     " quit if only list tag window left
let Tlist_File_Fold_Auto_Close=1    " auto fold

""" argwrap
nnoremap ,g :ArgWrap<Return>

""" autopep 8
" autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
" let g:autopep8_ignore="E501,W293"
" let g:autopep8_max_line_length=79
" let g:autopep8_indent_size=2 " this should be put in after together with indent setting
" let g:autopep8_disable_show_diff=1

""" yapf setting
autocmd FileType python set formatprg=yapf

""" setting for incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

""" setting for indentLine
" let g:indentLine_char = '┊'
" avoiding IndentLine to start for Markdown and tex files
" this is because IndentLine will set conceallevel to 2 by default which makes mk or tex files hard to read
autocmd FileType markdown let g:indentLine_enabled=0
autocmd FileType tex let g:indentLine_enabled=0

""" setting for tag bar
noremap tb :TagbarToggle<Return>
let g:tagbar_width=30   " width of tagbar
" let g:tagbar_width=50   " width of tagbar for wide screen in baidu speech
let g:tagbar_left=0     " tagbar window on the left(1 on the right)
let g:tagbar_sort = 0   " tags are sorted according to their order in the source file
let g:tagbar_show_linenumbers = 1

""" setting for YouCompleteMe
" noremap <F3> :YcmCompleter GetDoc<Return> " short cut for get document
" noremap <F4> :YcmCompleter GoToDeclaration<Return> " short cut for go to declaration
"
""" setting for sneak
let g:sneak#streak = 1
let g:sneak#use_ic_scs = 1
highlight Sneak guifg=black guibg=gray ctermfg=black ctermbg=gray
highlight link Sneak None

""" setting for neocomplete
let g:neocomplete#enable_at_startup = 1
" disable auto preview
set completeopt-=preview
" <TAB>: completion for neocomplete.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ neocomplete#start_manual_complete()
function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

""" setting for tags
set tags=./tags,tags;/
" Open the definition in a vertical split
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" setting for ultisnips
" Trigger configuration. Do not use <tab> if you use " https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger=",e"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["myultisnips", "UltiSnips"]

" setting for vim-command mode completion
set wildmenu "" using tab to navigate through files
set wildmode=list:longest,list:full "" tab at first, only print file list

" setting for EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Jump outside '"({
if !exists('g:AutoPairsShortcutJump')
  let g:AutoPairsShortcutJump = '<C-l>'
endif
