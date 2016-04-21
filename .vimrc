" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif " remember place
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
syntax on

set t_Co=256 "256 color mode
set number "set all line numbers
set relativenumber "lines relatively numbered from current
"set cursorline "cursor tracking"
"set cursorcolumn " cursor tracking"
"set background=dark
"colorscheme default
"set ruler
"set wrap
"set showbreak=...
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set hlsearch

set autoindent
set tabstop=2 "heresy
set softtabstop=2
set shiftwidth=2
"set expandtab
set shiftround
set smarttab "tabs at the beginning, spaces in the not beginning of a line

set ignorecase		" Do case insensitive matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
set autoread
set scrolloff=50 "scroll follows cursor
set lazyredraw
set ttyfast
"set omnifunc=no

" code folding options
set foldenable
set foldmethod=syntax "indent"
set foldlevelstart=10
"set foldnestmax=10
set foldlevel=1

"let &titlestring = "{" .hostname(). ": vim(" .expand("%:p"). ")}".expand($USER).""
"set title

"autocomplete menu options
set completeopt=menuone,preview


"vim-plug calls
call plug#begin()
Plug 'https://github.com/scrooloose/syntastic.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/jiangmiao/auto-pairs.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/vim-scripts/YankRing.vim.git'
Plug 'https://github.com/joequery/Stupid-EasyMotion.git'
Plug 'https://github.com/godlygeek/tabular.git'
call plug#end()

"vim airline status bar
set laststatus=2
let g:airline_theme='raven'


" YCM options
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

"yankring options
let g:yankring_history_dir = '~/.vim/plugged/YankRing.vim'

nmap tb :TagbarOpen fj<CR>
nmap ttb :TagbarToggle<CR>
nmap yr :YRShow<CR>
set pastetoggle=<F2>

