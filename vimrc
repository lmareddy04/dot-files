" Don't try to be vi compatible
set nocompatible

" Set Line number
set number relativenumber

" Show command in bottom bar
set showcmd             

" Enable filetype plugins
filetype indent plugin on

" Wild menu
set wildmenu
set wildignore=*.o,*~,*.pyc
set wildmode=list:longest,full

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

"Enables mouse copy
set mouse=a

"Toggle paste mode
set pastetoggle=<F2>

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Color scheme (terminal)
colorscheme molokai

" Enable colors within tmux
set term=xterm-256color

" Highlight Matching brackets
set showmatch

" Copy indent from current line when starting a new Line
set autoindent

" Better autoindent, adds indent after brackets
set smartindent

" Ignores case for match
set ignorecase

" Matches case if CAPS in the search
set smartcase

" Auto apply syntzx based on filetypes
au BufRead,BufNewFile *.vh,*.vs set filetype=systemverilog

" Add matchit pacakge
packadd! matchit

" Mappings to toggle line numbers
map <leader>l :set nu!<CR>
map <leader>r :set rnu!<CR>

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'preservim/nerdtree'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'godlygeek/tabular'

call plug#end()

" Nerdtree section
nnoremap <C-n> :NERDTreeToggle<CR>

" Airline Section
let g:airline_powerline_fonts = 1
let g:airline_theme= 'dark'

" Map ctrl+p to invoke fzf Files
" nnoremap <C-P> :FZF -m<CR>
nnoremap <C-P> :GFiles <CR>
