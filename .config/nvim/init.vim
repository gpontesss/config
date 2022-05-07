call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'

Plug 'itchyny/lightline.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'frazrepo/vim-rainbow'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'

Plug 'ptzz/lf.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'benmills/vimux'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-rooter'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'dense-analysis/ale', {'do': 'pip install black isort flake8'}

Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'lervag/vimtex'
Plug 'ncm2/ncm2-markdown-subscope'

Plug 'tpope/vim-fireplace'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}

call plug#end()

" =============================================================================
" LSP, linting and fixing
" =============================================================================

set nocompatible " required by vim-polyglot (and probably other plugins too)

lua <<EOF
require('lspconfig').clojure_lsp.setup{}
require('lspconfig').gopls.setup{}

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
  rainbow = {
     enable = true,
     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
     -- max_file_lines = nil, -- Do not enable for files with more than n lines, int
     -- colors = {}, -- table of hex strings
     -- termcolors = {} -- table of colour name strings
  },
}
EOF

autocmd BufWritePre *.clj lua vim.lsp.buf.formatting()

" some of fireplace's keymaps conflict with mine, so they are just overall
" disabled
let g:fireplace_no_maps = 1

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

let g:ale_linters = {
\   'markdown': ['proselint'],
\ }

" completion should be done with LSP and NCM2
let g:ale_completion_enabled = 0

" required by NCM2
let g:python3_host_prog = "/usr/bin/python3"

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
autocmd BufEnter * call ncm2#enable_for_buffer()


" =============================================================================
" buffer looks and misc. UI
" =============================================================================

syntax on
filetype plugin indent on
set number
set wildmenu
set nohlsearch
set wrap
set laststatus=3

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
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_statusline_style = 'mix'
set background=dark
colorscheme gruvbox-material

let g:rainbow_active = 1

let g:tex_flavor = 'latex'

let g:lf_replace_netrw = 1

" enables mouse support (only in normal mode)
set mouse=n
if !has('nvim') | set ttymouse=xterm2 | endif

" @@@ Lightline @@@
set noshowmode
if !has('gui_running') | set t_Co=256 | endif

let g:lightline = {
\   'colorscheme': 'gruvbox_material',
\   'active': {
\     'left': [ [ 'mode', 'paste' ],
\               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
\   },
\   'component_function': {
\     'gitbranch': 'FugitiveHead',
\   },
\ }

function! s:refresh_lightline()
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

" if has('python3') | set pyx=3 | endif


" =============================================================================
" Shortcut mapping
" =============================================================================

let mapleader = '\'
" switches to previous buffer
nmap <space><space> :b#<CR>

" clipboard copy/paste (for both normal/visual modes)
nmap <silent> <leader><C-C> "+y
vmap <silent> <C-C>         "+y
nmap <silent> <leader><C-V> "+p
vmap <silent> <C-V>         "+p

" Closes current buffer and goes to previous one
nmap <silent> <C-Q> <Cmd>bp<Bar>silent! bd!#<CR>

" opens vim config file in a buffer for editing
nmap <leader>C <Cmd>edit $MYVIMRC<CR>
" refreshes config file
nmap <silent> <leader>R
    \ <Cmd>source $MYVIMRC <Bar>
    \ call <SID>refresh_lightline() <Bar>
    \ echo "vimrc reloaded"<CR>

" Invokes make
nmap M <Cmd>!make<CR>
" repeats last command executed in vim's shell
nmap <silent> !! <Cmd>!!<CR>

" justifies paragraph around cursor
nmap <silent> gp gqap
" toggles all lines selection to be (un)commented
nmap <silent> # <Cmd>Commentary<CR>
vmap <silent> # <Cmd>Commentary<CR>

" opens a file manager navigation with lf
nmap <silent> <C-E> <Cmd>Lf<CR>

nmap <C-P> <Cmd>GFiles --cached --others<CR>
nmap <C-S> <Cmd>Buffers<CR>
nmap <C-F> <Cmd>Ag<CR>

" @@@ LSP shortcuts @@@
nnoremap <silent> gd <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <Cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g/ <Cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gT <Cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gi <Cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K  <Cmd>lua vim.lsp.buf.hover()<CR>

" =============================================================================
" vim-dispatch
" =============================================================================

autocmd FileType markdown let b:dispatch = 'pandoc % -o "$(basename % .md).pdf"'

" TODO: Shortcut to run test in REPL
" TODO: fix damn ctrl-P to work outside of git repo
" TODO: look at these plugins:
" + https://github.com/clojure-vim/vim-jack-in
" + https://github.com/mfussenegger/nvim-dap
" + https://www.cognitect.com/blog/2017/4/17/clojure-for-neovim-for-clojure
" + https://github.com/nvim-telescope/telescope.nvim
" + https://github.com/Olical/conjure
" + https://github.com/guns/vim-sexp
" + https://github.com/Shougo/ddc.vim

" For reference: https://github.com/nanotee/nvim-lua-guide
" Bunch of cool lua plugins: https://github.com/nvim-lua
