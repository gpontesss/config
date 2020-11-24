let mapleader = ' '

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-rooter'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale', {'do': 'pip install black isort flake8'}

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'jiangmiao/auto-pairs'
Plug 'lervag/vimtex'

call plug#end()

set number
set wildmenu

set expandtab
set tabstop=4
set shiftwidth=4

syntax on
filetype on

nmap <leader><leader> :

set colorcolumn=80
set textwidth=80
set formatoptions-=t

" Navigation
" nnoremap <silent> <A-S-Tab> :bn<CR>
nmap     <silent> <S-Tab> :bp<CR>

nmap <silent> <leader>rc :so $MYVIMRC<CR>:echo "Configs refreshed"<CR>

nmap <silent> <S-K> <C-W><C-K>
nmap <silent> <S-L> <C-W><C-L>
nmap <silent> <S-J> <C-W><C-J>
nmap <silent> <S-H> <C-W><C-H>

nmap <silent> <C-K> <C-W><S-K>
nmap <silent> <C-L> <C-W><S-L>
nmap <silent> <C-J> <C-W><S-J>
nmap <silent> <C-H> <C-W><S-H>

" !!! Currently not working
nnoremap <A-K> res +10<CR>
nnoremap <A-L> vert res +10<CR>
nnoremap <A-J> res -10<CR>
nnoremap <A-H> vert res -10<CR>

" Tree view
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_browse_split = 2 " opens files in horizontal split
let g:netrw_liststyle = 3

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

" NERDTree
let NERDTreeMapActivateNode='<Tab>'
let NERDTreeShowHidden=1

nmap <silent> <S-T>      :NERDTreeToggleVCS<CR>
nmap <silent> <leader>tr <S-T><S-T>

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

" Python specific
" Got to have it trigger only nor python, though
" autocmd BufWritePre *.py silent! execute ':Black'
" autocmd BufWritePost *.py !isort %
"
if has('python3')
    set pyx=3
endif
" Black's line length
autocmd BufEnter *.py set colorcolumn=89

" ALE
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'python': [
\        'isort',
\        'black',
\        'remove_trailing_lines',
\        'trim_whitespace',
\    ],
\   'go': ['gofmt'],
\}

let g:ale_linters = {'go': ['gofmt']}

" Shortcuts
nmap <leader>ee :e 
nmap <leader>eh :e ~/
nmap <leader>ec :e ~/.vimrc<CR>

nmap <leader>cp "+p
vmap <leader>cy "+y
vmap <leader>cp "+p

" Vimtex
let g:tex_flavor = 'latex'

LightlineReload

