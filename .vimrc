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

call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree'
call plug#end()

" Coc Config 
" let g:coc_global_extensions = [
"             \ 'coc-json', 
"             \ 'coc-tsserver',
"             \ 'coc-eslint',
"             \ 'coc-prettier',
"             \ 'coc-pairs',
"             \]

" inoremap <silent><expr> <C-@> coc#refresh()
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" NERDTree Config
" autocmd VimEnter * NERDTree | wincmd p  " Start VIM with NERDTree and with focus on file

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

