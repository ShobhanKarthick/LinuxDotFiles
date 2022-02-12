"          _
"   __   _(_)_ __ ___  _ __ ___
"   \ \ / / | '_ ` _ \| '__/ __|
"    \ V /| | | | | | | | | (__
"   (_)_/ |_|_| |_| |_|_|  \___|
"

let mapleader = " "
syntax on
filetype on
filetype plugin on

" Basics
set number
set relativenumber
set incsearch
set nohlsearch

" Indentation
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set pastetoggle=<F9>
set scrolloff=8
set showcmd
set wildmenu

command! WQ wq
command! Wq wq
command! wQ wq
command! W w
command! Q q
       
call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree'
    " Plug 'puremourning/vimspector'
call plug#end()

" ALE Config
" let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'python':['flake8']}

let g:ale_linters = {
            \   'javascript': ['eslint'],
            \   'typescript': ['tslint'],
            \   'python': ['flake8'],
            \}

let js_fixers = ['prettier', 'eslint']

let g:ale_fixers = {
		    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
			\   'javascript': js_fixers,
			\   'javascript.jsx': js_fixers,
			\   'typescript': js_fixers,
			\   'typescriptreact': js_fixers,
			\   'css': ['prettier'],
			\   'json': ['prettier'],
            \   'python': ['black', 'autopep8'],
            \}

let g:ale_fix_on_save = 1

" NERDTree Config
" autocmd VimEnter * NERDTree | wincmd p  " Start VIM with NERDTree and with focus on file

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" VimSpector Config
let g:vimspector_enable_mappings = 'HUMAN'
