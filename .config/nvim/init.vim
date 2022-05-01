call plug#begin('~/.vim/plugged')

" Style and looks
Plug 'itchyny/lightline.vim'
" gruvbox color theme
Plug 'morhetz/gruvbox'
" adds syntax highlight to many file formats
Plug 'sheerun/vim-polyglot'

" Enhancing functions
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
<<<<<<< HEAD
=======
Plug 'tpope/vim-eunuch'
>>>>>>> origin/macos
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

<<<<<<< HEAD
" golang
Plug 'benmills/vimux'
Plug 'sebdah/vim-delve'

Plug 'tpope/vim-dispatch'
=======
" clojure
" Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
Plug 'frazrepo/vim-rainbow'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-salve'
>>>>>>> origin/macos

call plug#end()

" =======================
" LSP, linting and fixing
" =======================

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'python': ['isort', 'black'],
\   'go': ['gofmt', "goimports"],
\   'javascript': ['prettier'],
\   'json': ['jq'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier', 'eslint'],
\   'dart': ['dartfmt'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }

let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
<<<<<<< HEAD
" let g:python3_host_prog = system("which python3")
=======
let g:ale_linters = {
\   'markdown': ['proselint'],
\ }
>>>>>>> origin/macos

" completion should be done with LSP and NCM2
let g:ale_completion_enabled = 0

" required by NCM2
let g:python3_host_prog = "/usr/local/bin/python3"

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
autocmd BufEnter * call ncm2#enable_for_buffer()


" =========================
" buffer looks and misc. UI
" =========================

syntax on
filetype on
set number
set wildmenu
set nohlsearch
set wrap

set colorcolumn=81
set textwidth=80
set formatoptions=cr

" Splits open at the bottom and right
set splitbelow splitright

" text enconding, tab settings, etc.
set encoding=utf-8
set expandtab
set tabstop=4
set shiftwidth=4

set hidden
set autowrite
set spell

" configures gruvbox theme
let g:gruvbox_termcolors=16
set background=dark
colorscheme gruvbox

" enables mouse support (only in normal mode)
set mouse=n
if !has('nvim')
    set ttymouse=xterm2
endif


" ================
" Shortcut mapping
" ================

let mapleader = ' '

" Cycles through buffers
nmap <silent> <S-Tab> :bp<CR>
" switches to previous buffer
nmap <leader><leader> :b#<CR>

" moves through panels
nmap <silent> <S-K> <C-W><C-K>
nmap <silent> <S-L> <C-W><C-L>
nmap <silent> <S-J> <C-W><C-J>
nmap <silent> <S-H> <C-W><C-H>

" clipboard copy/paste
nmap <silent> <leader>cy "+y
nmap <silent> <leader>cp "+p

" Closes current buffer and goes to previous one
nmap <silent> <leader>qq :bp\|bd#<CR>
" closes current window
nmap <silent> <leader>wq <C-W><C-Q>

" refreshes config file
nmap <silent> <leader>rc :so $MYVIMRC<CR>:echo "Configs refreshed"<CR>
" opens vim config file in a buffer for editing
nmap <leader>ec :e ~/.config/nvim/init.vim<CR>

" Invokes make
nmap M :!make<CR>
" repeats last command executed in vim's shell
nmap <silent> !! :!!<CR>

" justifies paragraph around cursor
nmap gp gqap
" toggles all lines selection to be (un)commented
nmap <silent> <leader>cc :Commentary<CR>

" opens a file manager navigation with lf
nmap <silent> <C-e> :Lf<CR>

nmap <C-P> :GFiles --cached --others<CR>
nmap <C-S> :Buffers<CR>
nmap <C-F> :Ag<CR>

" @@@ LSP shortcuts @@@
" jumps to symbol definition
nmap <silent> <leader>dd :LspDefinition<CR>
" renames a symbol in the entire project
" TODO: save it afterwards automatically?
nnoremap <silent> cn :LspRename<CR>


" =========
" Lightline
" =========
"
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

if has('python3')
    set pyx=3
endif

<<<<<<< HEAD
" Shortcuts
nmap <leader>ec :e ~/.config/nvim/init.vim<CR>

nmap gp gqap

nmap <leader>cy "+y
nmap <leader>cp "+p
vmap <leader>cy "+y
vmap <leader>cp "+p

nmap <silent> M     :Dispatch!<CR>
" nmap <silent> <C-e> :RnvimrToggle<CR>
nmap <silent> <C-e> :Lf<CR>
nmap <silent> !!    :!!<CR>

nmap     <C-P> :GFiles --cached --others<CR>
nmap     <C-S> :Buffers<CR>
nmap     <C-F> :Ag<CR>

nnoremap <silent> cn :LspRename<CR>

=======
>>>>>>> origin/macos
" Vimtex
let g:tex_flavor = 'latex'

" Lf
let g:lf_replace_netrw = 1 " Open lf when vim opens a directory

<<<<<<< HEAD
" golang/delve
let g:delve_breakpoint_sign = "*"
let g:delve_use_vimux = 1
nmap <silent> <leader>bb :DlvToggleBreakpoint<CR>

LightlineReload

" dispatch rules
autocmd FileType markdown let b:dispatch = 'pandoc % -o "$(basename % .md).pdf"'
=======
" rainbow parenthesis
let g:rainbow_active = 1

LightlineReload

" LspRename save all files? solution: use :wa after renaming
" => maybe consider redefining function
" Shortcut to run test in REPL
" linting? (unscoped symbols)
>>>>>>> origin/macos
