let mapleader = " "
syntax on
filetype plugin on

" Basics
set number 
set relativenumber
set incsearch

" Indentation 
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set scrolloff=8

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Coc Config 
let g:coc_global_extensions = [
            \ 'coc-json', 
            \ 'coc-tsserver',
            \ 'coc-json',
            \ 'coc-snippets',
            \ 'coc-eslint',
            \ 'coc-prettier',
            \]
