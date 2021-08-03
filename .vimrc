let mapleader = " "
syntax on
filetype on
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
    Plug 'preservim/nerdtree'
call plug#end()

" Coc Config 
let g:coc_global_extensions = [
            \ 'coc-json', 
            \ 'coc-tsserver',
            \ 'coc-snippets',
            \ 'coc-eslint',
            \ 'coc-prettier',
            \ 'coc-pairs',
            \]

inoremap <silent><expr> <C-@> coc#refresh()

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" NERDTree Config
autocmd VimEnter * NERDTree | wincmd p  " Start VIM with NERDTree and with focus on file

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

