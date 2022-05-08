set tabstop=4
syntax on
set number

call plug#begin()

" Syntax Highlighting
Plug 'sheerun/vim-plyglot'

" Status Bar
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'

" Tree
Plug 'scrooloose/nerdtree'

" Autoclosing
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-sorround'

" Autocompletation 
Plug 'sirver/ultisnips'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" IDE
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'mhinz/vim-signify'
Plug 'yggdroot/indentline'
Plug 'scrooloose/nerdcommenter'

call plug#end()
