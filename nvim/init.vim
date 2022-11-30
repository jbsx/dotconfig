set shell=/bin/bash
call plug#begin('~/.config/nvim/plugged')

" Nvim configuration

"LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'

"Editor
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-sensible'

"Visual
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'sbdchd/neoformat'
Plug 'luochen1990/rainbow'
Plug 'sheerun/vim-polyglot'
Plug 'gruvbox-community/gruvbox'
Plug 'folke/tokyonight.nvim'

"MISCELLANEOUS
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    "Svelte syntax highlighting
    Plug 'othree/html5.vim'
    Plug 'pangloss/vim-javascript'
    Plug 'evanleck/vim-svelte', {'branch': 'main'}


call plug#end()

" Colorscheme
let base16colorspace=256

"let g:tokyonight_style = 'night'
"let g:tokyonight_enable_italic = 1
"colorscheme tokyonight-night

colorscheme gruvbox

" Remove colorscheme background
hi Normal guibg=NONE ctermbg=None

" luochen1990/rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" lightline
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ],
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" Autocomplete
set completeopt=menu,menuone,noselect

set number relativenumber
set mouse=a
set cursorline
syntax enable
filetype plugin indent on
set encoding=utf-8
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set incsearch
set scrolloff=8
set nohlsearch
"set nowrap

" Firenvim settings
if exists('g:started_by_firenvim')
    set guifont=LiterationMono\ Nerd\ Font:h12
    highlight ExtraWhitespace guibg=NONE ctermbg=NONE
    colorscheme tokyonight-night
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


" ################## KEY MAPS ##################

let mapleader = "\<Space>"

" Ctrl+j and Ctrl+k as Esc
" Ctrl-j is a little awkward unfortunately:
" https://github.com/neovim/neovim/issues/5916
" So we also map Ctrl+k
nnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
snoremap <C-j> <Esc>
xnoremap <C-j> <Esc>
cnoremap <C-j> <C-c>
onoremap <C-j> <Esc>
lnoremap <C-j> <Esc>
tnoremap <C-j> <Esc>

nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <C-c>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

map <A-J> :m +1<CR>
map <A-K> :m -2<CR>

" remapping J and K to free keybinds for vertical scroll
nnoremap <A-k> K
nnoremap <A-j> J

" Vertical Movement
noremap J <C-d>zz
noremap K <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Jump to start and end of line using the home row keys
map H ^
map L $

inoremap jj <esc>
nnoremap <leader><leader> <C-^>
inoremap <esc> <C-o>:echo "NO ESAPCE FOR YOU"<CR>
nnoremap <C-n> :silent! NERDTreeToggle<CR>

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

" FZF
nnoremap <leader>ff :FZF<CR>
" fg = grep (ripgrep)
nnoremap <leader>r :Rg<CR>
" fb = BLines
nnoremap <leader>fb :BLines<CR>
" t = buffers
nnoremap <leader>t :Buf<CR>

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
nmap <leader>o :lua vim.diagnostic.open_float() <CR>
nmap <A-e> :lua vim.diagnostic.goto_next() <CR>
nmap <A-E> :lua vim.diagnostic.goto_prev() <CR>
nmap <leader>2 :lua vim.lsp.buf.rename() <CR>
nmap <A-p> :ToggleDiag <CR>

" LSP

lua << EOF
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, {buffer=0})
-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
-- vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
-- vim.keymap.set("n", "<leader>o", vim.diagnostic.open_float, {buffer=0})
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.goto_next, {buffer=0})
-- vim.keymap.set("n", "<leader>E", vim.diagnostic.goto_prev, {buffer=0})
-- vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})

require('lspconfig')['tsserver'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
      ["rust-analyzer"] = {}
    }
}
require('lspconfig')['pyright'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
}

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

EOF
