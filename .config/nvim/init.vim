call plug#begin('~/.vim/plugged')

" Style and looks
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'

" Enhancing functions
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'kevinhwang91/rnvimr'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Linting
Plug 'dense-analysis/ale', {'do': 'pip install black isort flake8'}

"NCM2 related (suggestion/completion)
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'lervag/vimtex'
Plug 'ncm2/ncm2-markdown-subscope'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'ncm2/ncm2-vim-lsp'

call plug#end()

let mapleader = ' '

" ALE
let g:ale_fixers = {
\   'python': ['isort', 'black'],
\   'go': ['gofmt', "goimports"],
\   'javascript': ['prettier'],
\   'json': ['jq'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier', 'eslint'],
\   'dart': ['dartfmt'],
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}

let g:ale_linters = {
\   'markdown': ['proselint']
\}

let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0

" NCM2
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:python3_host_prog = "/usr/bin/python3"


autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

au InsertEnter * call ncm2#enable_for_buffer()
   au Filetype tex call ncm2#register_source({
       \ 'name' : 'vimtex-cmds',
       \ 'priority': 8,
       \ 'complete_length': -1,
       \ 'scope': ['tex'],
       \ 'matcher': {'name': 'prefix', 'key': 'word'},
       \ 'word_pattern': '\w+',
       \ 'complete_pattern': g:vimtex#re#ncm2#cmds,
       \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
       \ })
   au Filetype tex call ncm2#register_source({
       \ 'name' : 'vimtex-labels',
       \ 'priority': 8,
       \ 'complete_length': -1,
       \ 'scope': ['tex'],
       \ 'matcher': {'name': 'combine',
       \             'matchers': [
       \               {'name': 'substr', 'key': 'word'},
       \               {'name': 'substr', 'key': 'menu'},
       \             ]},
       \ 'word_pattern': '\w+',
       \ 'complete_pattern': g:vimtex#re#ncm2#labels,
       \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
       \ })
   au Filetype tex call ncm2#register_source({
       \ 'name' : 'vimtex-files',
       \ 'priority': 8,
       \ 'complete_length': -1,
       \ 'scope': ['tex'],
       \ 'matcher': {'name': 'combine',
       \             'matchers': [
       \               {'name': 'abbrfuzzy', 'key': 'word'},
       \               {'name': 'abbrfuzzy', 'key': 'abbr'},
       \             ]},
       \ 'word_pattern': '\w+',
       \ 'complete_pattern': g:vimtex#re#ncm2#files,
       \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
       \ })
   au Filetype tex call ncm2#register_source({
       \ 'name' : 'bibtex',
       \ 'priority': 8,
       \ 'complete_length': -1,
       \ 'scope': ['tex'],
       \ 'matcher': {'name': 'combine',
       \             'matchers': [
       \               {'name': 'prefix', 'key': 'word'},
       \               {'name': 'abbrfuzzy', 'key': 'abbr'},
       \               {'name': 'abbrfuzzy', 'key': 'menu'},
       \             ]},
       \ 'word_pattern': '\w+',
       \ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
       \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
       \ })

""""

set number
set wildmenu
set nohlsearch
set encoding=utf-8

set expandtab
set wrap
set tabstop=4
set shiftwidth=4

set hidden
set autowrite

syntax on
filetype on

" Splits open at the bottom and right
set splitbelow splitright

nmap <silent> <leader>rc :so $MYVIMRC<CR>:echo "Configs refreshed"<CR>

set colorcolumn=81
set textwidth=80
set formatoptions-=t

" Navigation
nmap <silent> <S-Tab> :bp<CR>
nmap <leader><leader> :b#<CR>

nmap <silent> <S-K> <C-W><C-K>
nmap <silent> <S-L> <C-W><C-L>
nmap <silent> <S-J> <C-W><C-J>
nmap <silent> <S-H> <C-W><C-H>

nnoremap <silent> <C-K> :res +5<CR>
nnoremap <silent> <C-L> :vert res +5<CR>
nnoremap <silent> <C-J> :res -5<CR>
nnoremap <silent> <C-H> :vert res -5<CR>

nmap <silent> <leader>dd :LspDefinition<CR>

" Windows and buffers
" Closes current buffer and goes to previous one
nmap <silent> <leader>qq :bp\|bd#<CR>
nmap <silent> <leader>ba :ls<CR>

nmap <silent> <leader>tn :tabn<CR>
nmap <silent> <leader>tp :tabp<CR>

nmap <silent> <leader>wq <C-W><C-Q>

" Lightline
if !has('gui_running')
    set t_Co=256
endif

set noshowmode
set laststatus=2

let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
    \ }

command! LightlineReload call LightlineReload()

function! LightlineReload()
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

" Gruvbox color scheme
set background=dark
let g:gruvbox_termcolors=16

colorscheme gruvbox

" Mouse window resizing
set mouse=n
if !has('nvim')
    set ttymouse=xterm2
endif

" Git/Fugitive
nmap <leader>gc :vert Git commit --verbose<CR>
nmap <leader>gd :vert Git diff<CR>
nmap <leader>gs :Git status -s<CR>
nmap <leader>ga :vert Git add . -p<CR>
nmap <leader>gu :Git reset .<CR>
nmap <leader>gg :vert Git diff --staged<CR>
nmap <leader>gk :Git checkout
nmap <leader>gp :Git pull -p<CR>

if has('python3')
    set pyx=3
endif

" Shortcuts
nmap <leader>ec :e ~/.config/nvim/init.vim<CR>

nmap gp gqap

nmap <leader>cy "+y
nmap <leader>cp "+p
vmap <leader>cy "+y
vmap <leader>cp "+p

nmap          M     :!make<CR>
" nmap <silent> <C-e> :RnvimrToggle<CR>
nmap <silent> <C-e> :Lf<CR>
nmap <silent> !!    :!!<CR>

nmap     <C-P> :GFiles --cached --others<CR>
nmap     <C-S> :Buffers<CR>
nmap     <C-F> :Ag<CR>

nnoremap <silent> cn :LspRename<CR>

" Vimtex
let g:tex_flavor = 'latex'

" Lf
let g:lf_replace_netrw = 1 " Open lf when vim opens a directory

LightlineReload
