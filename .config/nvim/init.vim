call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'andersevenrud/cmp-tmux'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-emoji'
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'

Plug 'itchyny/lightline.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'frazrepo/vim-rainbow'
Plug 'sheerun/vim-polyglot'
Plug 'p00f/nvim-ts-rainbow'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'ptzz/lf.vim'

Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-rooter'

Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'benmills/vimux'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-fireplace'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}

call plug#end()

" =============================================================================
" LSP, linting and fixing
" =============================================================================

set nocompatible " required by vim-polyglot (and probably other plugins too)

lua <<EOF
local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities())

require('lspconfig').clojure_lsp.setup{ capabilities = capabilities }
require('lspconfig').gopls.setup{ capabilities = capabilities }

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same
    -- time. Set this to `true` if you depend on 'syntax' being enabled (like for
    -- indentation). Using this option may slow down your editor, and you may see
    -- some duplicate highlights. Instead of true it can also be a list of
    -- languages additional_vim_regex_highlighting = false,
  },
  rainbow = {
     enable = true,
     --  list of languages you want to disable the plugin for
     -- disable = { "jsx", "cpp" },
     -- Also highlight non-bracket delimiters like html tags, boolean or table:
     -- lang -> boolean
     extended_mode = true,
     -- Do not enable for files with more than n lines, int
     -- max_file_lines = nil,
     -- table of hex strings
     -- colors = {},
     -- table of colour name strings
     -- termcolors = {}
  },
}
EOF

autocmd BufWritePre *.clj lua vim.lsp.buf.formatting()

lua <<EOF
local cmp = require('cmp')

cmp.setup({
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
    end,
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-U>'] = cmp.mapping.scroll_docs(-4),
      ['<C-D>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      -- Accept currently selected item. Set `select` to `false` to only confirm
      -- explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'tmux' },
      { name = 'emoji' },
    })
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'cmdline' },
    })
})
EOF

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

let g:lf_replace_netrw = 1

set background=dark
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_palette = 'mix'
let g:gruvbox_material_statusline_style = 'mix'
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_cursor = 'orange'
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:gruvbox_material_diagnostic_text_highlight = 1
let g:gruvbox_material_diagnostic_virtual_text = 'colored'
let g:gruvbox_material_menu_selection_background = 'red'
let g:gruvbox_material_spell_foreground = 'colored'
let g:gruvbox_material_current_word = 'underline'
colorscheme gruvbox-material

let g:rainbow_active = 1

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

" =============================================================================
" Key mapping
" =============================================================================

" some of fireplace's keymaps conflict with mine, so they are just overall
" disabled
let g:fireplace_no_maps = 1

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
nmap <silent> # :Commentary<CR>
vmap <silent> # :Commentary<CR>

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
inoremap <silent> <C-Space> <Cmd> lua vim.lsp.buf.signature_help()<CR>

" =============================================================================
" vim-dispatch
" =============================================================================

autocmd FileType markdown let b:dispatch = 'pandoc % -o "$(basename % .md).pdf"'

" TODO: Shortcut to run test in REPL
" TODO: fix damn ctrl-P to work outside of git repo
" TODO: setup spell checking
" TODO: checkout chad-looking https://github.com/tpope/vim-dadbod
" TODO: look at these plugins:
" + https://github.com/clojure-vim/vim-jack-in
" + https://github.com/mfussenegger/nvim-dap
" + https://www.cognitect.com/blog/2017/4/17/clojure-for-neovim-for-clojure
" + https://github.com/nvim-telescope/telescope.nvim
" + https://github.com/Olical/conjure
" + https://github.com/guns/vim-sexp

" For reference: https://github.com/nanotee/nvim-lua-guide
" Bunch of cool lua plugins: https://github.com/nvim-lua
