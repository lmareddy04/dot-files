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

"For mouse to work inside tmux -- only for older versions of tmux
"set ttymouse=xterm2

"Toggle paste mode
set pastetoggle=<F2>

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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
au BufRead,BufNewFile *.vh,*.vs,*.f set filetype=systemverilog

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
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'andymass/vim-matchup'
Plug 'luochen1990/rainbow'
Plug 'tinted-theming/base16-vim'
call plug#end()

" Nerdtree section
nnoremap <C-n> :NERDTreeToggle<CR>

" Enable colors within tmux
set termguicolors
"set term=xterm-256color

" Color scheme (terminal)
" colorscheme molokai
let base16colorspace=256
"colorscheme base16-ayu-mirage
colorscheme base16-ayu-dark 

" Airline Section
let g:airline_powerline_fonts = 1
"let g:airline_theme= 'dark'
"let g:airline_theme = 'ayu_mirage'
let g:airline_theme = 'ayu_dark'
let g:airline#extensions#default#layout = [['a','b','c'], ['x','y','z']]

" Map ctrl+p to invoke fzf Files
" nnoremap <C-P> :FZF -m<CR>
nnoremap <C-P> :GFiles <CR>
nnoremap <C-F> :Files <CR>
nnoremap <C-B> :Buffers <CR>
 
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Remapping the auto-fill file paths ctrl+x ctrl+f
inoremap <C-f> <C-x><C-f>

"Enable rainbow paranthesis
let g:rainbow_active = 0
nnoremap <C-r> :RainbowToggle<CR>
