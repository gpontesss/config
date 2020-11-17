let mapleader = ' '

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'

Plug 'psf/black', {'branch': 'stable'}

call plug#end()

set number
set wildmenu

set expandtab
set tabstop=4
set shiftwidth=4
syntax on

" Navigation
nmap <silent> <A-Tab> :bn<CR>
nmap <silent> <S-Tab> :bp<CR>

nmap <silent> <leader>r :so $MYVIMRC<CR>:echo "Configs refreshed"<CR>

nmap <silent> <S-K> <C-W><C-K>
nmap <silent> <S-L> <C-W><C-L>
nmap <silent> <S-J> <C-W><C-J>
nmap <silent> <S-H> <C-W><C-H>

nmap <silent> <C-K> <C-W><S-K>
nmap <silent> <C-L> <C-W><S-L>
nmap <silent> <C-J> <C-W><S-J>
nmap <silent> <C-H> <C-W><S-H>

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
nmap <silent> <leader>q     :bp\|bd#<CR>
nmap <silent> <leader><Tab> :ls<CR>


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
nmap <leader>gc :Git commit --verbose<CR>
nmap <leader>gd :Git diff<CR>
nmap <leader>gs :Git status -s<CR>
nmap <leader>ga :Git add . -p<CR>
nmap <leader>gu :Git reset .<CR>
nmap <leader>gg :Git diff --staged<CR>

" Python specific
nnoremap <C-S-I> :Black<CR>
" autocmd BufWritePre *.py silent! execute ':Black'
if has('python3')
    set pyx=3
endif

LightlineReload

