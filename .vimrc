let mapleader = ' '

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale', {'do': 'pip install black isort flake8 python-language-server'}

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'

Plug 'rhysd/vim-grammarous'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'oncomouse/ncm2-biblatex'
Plug 'ncm2/ncm2-go'
Plug 'ncm2/ncm2-racer'
Plug 'ncm2/ncm2-syntax'
Plug 'lervag/vimtex'
Plug 'ncm2/ncm2-gtags'
Plug 'jsfaint/gen_tags.vim'

call plug#end()


let $GTAGSCONF="/usr/share/gtags/gtags.conf"
let $GTAGSLABEL="pygments"

" ALE

let g:python3_host_prog = "/usr/bin/python3"

let g:ale_fixers = {
\   'python': ['isort', 'black'],
\   'go': ['gofmt'],
\   'javascript': ['prettier'],
\   'json': ['jq'],
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}

let g:ale_linters = {
\   'markdown': ['proselint']
\}

let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_lint_on_text_changed = 0

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

""""""

set number
set wildmenu

set expandtab
set wrap
set tabstop=4
set shiftwidth=4

set hidden

syntax on
filetype on


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

if has('python3')
    set pyx=3
endif


" Black's line length
" Hacky for now. maybe use .editorconfig, or something in the future?
autocmd BufEnter *.py set colorcolumn=89


" Shortcuts
nmap <leader>ee :e
nmap <leader>eh :e ~/
nmap <leader>ec :e ~/.vimrc<CR>

nmap <leader>cy "+y
nmap <leader>cp "+p
vmap <leader>cy "+y
vmap <leader>cp "+p

nmap M :!make<CR>

" Vimtex
let g:tex_flavor = 'latex'

" fzf
nmap     <C-P>   :GFiles<CR>
nmap     <C-S-P> :Buffers<CR>
nmap     <C-F>   :Rg<CR>
nnoremap <C-S>   :Lines<CR>

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

LightlineReload
