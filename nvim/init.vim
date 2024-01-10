set shell=/bin/bash
call plug#begin('~/.config/nvim/plugged')

"LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'

"Editor
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-sensible'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mbbill/undotree'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

"MISCELLANEOUS
Plug 'vim-airline/vim-airline'
Plug 'sbdchd/neoformat'
Plug 'luochen1990/rainbow'
Plug 'sheerun/vim-polyglot'
Plug 'gruvbox-community/gruvbox'
Plug 'folke/tokyonight.nvim'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()

" Colorscheme
let base16colorspace=256
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1

colorscheme gruvbox

" Remove background
"hi Normal guibg=NONE ctermbg=None
"hi cursorline guibg=NONE ctermbg=None
"hi CursorLineNR ctermbg=NONE

" luochen1990/rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" Autocomplete
set completeopt=menu,menuone,noselect

set number relativenumber
set mouse=a
set cursorline
syntax enable
filetype off
"filetype plugin indent on
set encoding=utf-8
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set incsearch
set scrolloff=8
set nohlsearch
set nowrap

" Firenvim settings
if exists('g:started_by_firenvim')
    colorscheme gruvbox
    set guifont=LiterationMono\ Nerd\ Font:h12
    let g:firenvim_config = { 
        \ 'globalSettings': {
            \ 'alt': 'all',
        \  },
        \ 'localSettings': {
            \ '.*': {
                \ 'cmdline': 'neovim',
                \ 'content': 'text',
                \ 'priority': 0,
                \ 'selector': 'textarea',
                \ 'takeover': 'never',
            \ },
        \ }
    \ }
    let fc = g:firenvim_config['localSettings']
    let fc['https?://leetcode.com/'] = { 'takeover': 'always', 'priority': 1 }
endif

" Neoformat
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']

" Limelight
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
" Default: 0.5
let g:limelight_default_coefficient = 0.7
" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 2
" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'
" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" ################## KEY MAPS ##################

let mapleader = "\<Space>"

" move line
map <A-J> :m '>+1<CR>gv=gv
map <A-K> :m '<-2<CR>gv=gv

" remapping J and K to free keybinds for vertical scroll
nnoremap <A-k> K
nnoremap <A-j> J

" Vertical Movement
noremap J <C-d>
noremap K <C-u>

" Jump to start and end of line using the home row keys
map H ^
map L $

inoremap jj <esc>
nnoremap <leader><leader> <C-^>

" switch brackets
nnoremap <leader>[ %
"inoremap <esc> <C-o>:echo "NO ESAPCE FOR YOU"<CR>

inoremap <C-H> <C-w>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap <A-P> :bp<CR>
nnoremap <A-N> :bn<CR>

" Close buffer
nnoremap <A-d> :bd<CR>

" FZF
"nnoremap <leader>ff :FZF<CR>
"nnoremap <leader>ff :GFiles<CR>
nnoremap <leader>ff :Files<CR>
" fg = grep (ripgrep)
nnoremap <leader>r :Rg<CR>
" fb = BLines
nnoremap <leader>fb :BLines<CR>
" t = buffers
nnoremap <leader>t :Buf<CR>

"undotree
nnoremap <A-u> :UndotreeToggle<CR>

"Netrw
nnoremap go :Ex<CR>

"nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>

" Quick-save and prettier
map <leader>w :Neoformat \| w<CR>

" yank to xclip
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$

" LSP keybinds
nmap <leader>k :lua vim.lsp.buf.hover() <CR>
nmap gd :lua vim.lsp.buf.definition() <CR>
nmap gt :lua vim.lsp.buf.type_definition() <CR>
nmap gi :lua vim.lsp.buf.implementation() <CR>
nmap gr :lua vim.lsp.buf.references() <CR>
nmap <leader>q :lua vim.diagnostic.setloclist() <CR>
nmap <leader>o :lua vim.diagnostic.open_float() <CR>
nmap <A-e> :lua vim.diagnostic.goto_next() <CR>
nmap <A-E> :lua vim.diagnostic.goto_prev() <CR>
nmap <leader>2 :lua vim.lsp.buf.rename() <CR>
nmap <A-p> :ToggleDiag <CR>
nmap <leader>ca :lua vim.lsp.buf.code_action() <CR>

"-------------------------Vsnip-------------------------
" Expand
imap <expr> <A-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <A-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <A-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <A-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" LSP
lua << EOF
-----------------------Treesitter-----------------------
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  }
}

---------------------Set up nvim-cmp--------------------

local cmp = require'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
        },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
        },
    mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    -- hrsh7th/cmp-nvim-lsp-signature-help
    { name = 'nvim_lsp_signature_help' }
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
})

---------------------LSPconfig setup--------------------

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true --cssls, jsonls

require'lspconfig'.tsserver.setup{capabilities = capabilities}
require'lspconfig'.rust_analyzer.setup{capabilities = capabilities}
require'lspconfig'.gopls.setup{capabilities = capabilities}
require'lspconfig'.pyright.setup{capabilities = capabilities}
require'lspconfig'.svelte.setup{capabilities = capabilities}
require'lspconfig'.clangd.setup{capabilities = capabilities}
require'lspconfig'.cssls.setup {capabilities = capabilities}
require'lspconfig'.jsonls.setup {capabilities = capabilities}
require'lspconfig'.prismals.setup{capabilities = capabilities}
require'lspconfig'.html.setup {capabilities = capabilities}
require'lspconfig'.solidity.setup{capabilities = capabilities}
require'lspconfig'.texlab.setup{capabilities = capabilities}
require'lspconfig'.astro.setup({
capabilities = capabilities,
  init_options = {
    typescript = {
      tsdk = vim.fs.normalize('/usr/lib/node_modules/typescript/lib')
    }
  },
})

EOF
