call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'rcarriga/nvim-dap-ui'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'andersevenrud/cmp-tmux'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-emoji'
Plug 'rcarriga/cmp-dap'
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'

Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'

Plug 'itchyny/lightline.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'frazrepo/vim-rainbow'
Plug 'sheerun/vim-polyglot'
Plug 'p00f/nvim-ts-rainbow'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

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
Plug 'tpope/vim-salve'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}

call plug#end()

" =============================================================================
" LSP, linting and fixing
" =============================================================================

set nocompatible " required by vim-polyglot (and probably other plugins too)

lua <<EOF
require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical'
  },
  ["ui-select"] = {
    require("telescope.themes").get_dropdown()
  },
})
require('telescope').load_extension('fzf')
EOF

lua <<EOF
require('dapui').setup()
require("nvim-dap-virtual-text").setup()
require('dap-go').setup()
EOF

lua <<EOF
local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities())

require('lspconfig').clojure_lsp.setup{ capabilities = capabilities }
require('lspconfig').gopls.setup{ capabilities = capabilities }
require('lspconfig').vimls.setup{ capabilities = capabilities }

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
  indent = { enable = true },
} 
EOF
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

autocmd BufWritePre *.clj lua vim.lsp.buf.formatting()

lua <<EOF
local cmp = require('cmp')

cmp.setup({
    enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
    end,
    -- REQUIRED - you must specify a snippet engine
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-U>'] = cmp.mapping.scroll_docs(-4),
      ['<C-D>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Down>'] = function(fallback)
        if cmp.visible() then cmp.select_next_item() else fallback() end
      end,
      ['<Up>'] = function(fallback)
        if cmp.visible() then cmp.select_prev_item() else fallback() end
      end,
      -- Accept currently selected item. Set `select` to `false` to only confirm
      -- explicitly selected items.
      ['<Tab>'] = cmp.mapping.confirm({ select = false }),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'tmux' },
      { name = 'emoji' },
      { name = 'dap' },
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
" set spell

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

function! s:refresh_lightline()
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

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
if has("mac")
    nmap <silent> <leader><C-C> "*y
    vmap <silent> <C-C>         "*y
    nmap <silent> <leader><C-V> "*p
    vmap <silent> <C-V>         "*p
else
    nmap <silent> <leader><C-C> "+y
    vmap <silent> <C-C>         "+y
    nmap <silent> <leader><C-V> "+p
    vmap <silent> <C-V>         "+p
endif

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
" remaps ctrl+C to ESC, for visual block substitution
vnoremap <C-C> <ESC>

nnoremap <silent> <C-Z> <C-W>\|<C-W>_
nnoremap <silent> <C-G> <Cmd>Goyo<CR>

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" justifies paragraph around cursor
nmap <silent> gp gqap
" toggles all lines selection to be (un)commented
nmap <silent> # :Commentary<CR>
vmap <silent> # :Commentary<CR>

" opens a file manager navigation with lf
nmap <silent> <C-E> <Cmd>Lf<CR>

nmap <silent> gm <Cmd>TSHighlightCapturesUnderCursor<CR>

nnoremap <silent> <C-P> <Cmd>Telescope find_files hidden=true<CR>
nnoremap <silent> <C-S> <Cmd>Telescope buffers<CR>
nnoremap <silent> <C-F> <Cmd>Telescope live_grep<CR>
nnoremap <silent> <C-X> <Cmd>Telescope diagnostics<CR>
nnoremap <silent> <C-X> <Cmd>Telescope diagnostics bufnr=0<CR>
nnoremap <silent> <C-M> <Cmd>Telescope help_tags<CR>

nnoremap <silent> gd <Cmd>Telescope lsp_definitions<CR>
nnoremap <silent> gD <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> g/ <Cmd>Telescope lsp_dynamic_workspace_symbols<CR>
nnoremap <silent> g? <Cmd>Telescope lsp_document_symbols<CR>
nnoremap <silent> gr <Cmd>Telescope lsp_references<CR>
nnoremap <silent> gT <Cmd>Telescope lsp_type_definitions<CR>
nnoremap <silent> gi <Cmd>Telescope lsp_implementations<CR>
nnoremap <silent> K  <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> cn  <Cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ca  <Cmd>lua vim.lsp.buf.code_action()<CR>
inoremap <silent> <C-Space> <Cmd>lua vim.lsp.buf.signature_help()<CR>

" TODO: is it possible to only map those when in debug mode? or maybe try using
" F-keys
" TODO: integrate debugging status in lightline
nmap <silent> <F2>b <Cmd>lua require("dap").toggle_breakpoint()<CR>
nmap <silent> <F2>B <Cmd>lua require("dap").toggle_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>
nmap <silent> <F2>n <Cmd>lua require("dap").step_over()<CR>
nmap <silent> <F2>N <Cmd>lua require("dap").step_back()<CR>
nmap <silent> <F2>i <Cmd>lua require("dap").step_into()<CR>
nmap <silent> <F2>o <Cmd>lua require("dap").step_out()<CR>
nmap <silent> <F2>d <Cmd>lua require("dap").step_out()<CR>
nmap <silent> <F2>c <Cmd>lua require("dap").continue()<CR>
nmap <silent> <F2>C <Cmd>lua require("dap").close()<CR>
nmap <silent> <F2>r <Cmd>lua require("dap").repl.toggle()<CR>

" =============================================================================
" vim-dispatch
" =============================================================================

autocmd FileType markdown let b:dispatch = 'pandoc % -o "$(basename % .md).pdf"'

" =============================================================================
" highlights and signs
" =============================================================================

highligh TSFunction ctermfg=Yellow
highligh TSNumber ctermfg=DarkCyan
highlight TSSymbol ctermfg=DarkBlue cterm=italic
highlight TSType ctermfg=67 cterm=italic
highlight link TSFuncBuiltin TSFunction
highlight link TSFuncMacro TSConditional
highlight link TSKeywordOperator TSFunction
highlight TSVariable ctermfg=Fg
highlight TSBoolean ctermfg=132
highlight TSString ctermfg=75
highlight link TSMethod TSSymbol
highlight TSOperator ctermfg=136
highlight link TSProperty TSSymbol
highlight TSParameter ctermfg=222

sign define DapBreakpoint text=* texthl=Red
sign define DapBreakpointCondition text=* texthl=Blue
sign define DapLogPoint text=* texthl=Purple
sign define DapStopped text=* texthl=Green
sign define DapBreakpointRejected text=* texthl=Yellow

autocmd BufEnter go.mod set filetype=gomod



" TODO: Shortcut to run test in REPL
" TODO: setup spell checking
" TODO: checkout chad-looking https://github.com/tpope/vim-dadbod
" TODO: look at these plugins:
" + https://www.cognitect.com/blog/2017/4/17/clojure-for-neovim-for-clojure
" + https://github.com/Olical/conjure
" + https://github.com/guns/vim-sexp

" For reference: https://github.com/nanotee/nvim-lua-guide
" Bunch of cool lua plugins: https://github.com/nvim-lua
