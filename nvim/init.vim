set shell=/bin/bash
call plug#begin('~/.config/nvim/plugged')

" Nvim configuration
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sensible'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'chriskempson/base16-vim'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'sbdchd/neoformat'
Plug 'luochen1990/rainbow'
Plug 'sheerun/vim-polyglot'
Plug 'gruvbox-community/gruvbox'

call plug#end()

" Colorscheme
let base16colorspace=256
colorscheme gruvbox

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

"For Types hint 
hi default CocRustTypeHint ctermbg=0 ctermfg=DarkGray
hi default CocRustChainingHint ctermbg=0 ctermfg=DarkGray
hi Normal guibg=NONE ctermbg=NONE

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
set nowrap


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

nnoremap <leader>k K

" Jump to start and end of line using the home row keys
map H ^
map L $

" Vertical Movement
nnoremap J <C-d>zz
nnoremap K <C-u>zz

inoremap jj <esc>
nnoremap <leader><leader> <C-^>
inoremap <esc> <C-o>:echo "NO ESAPCE FOR YOU"<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

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
nnoremap <leader>f  :FZF<CR>
" g = grep (ripgrep)
nnoremap <leader>g  :Rg<CR>
" h = home
nnoremap <leader>h  :FZF ~/<CR>
" b = BLines
nnoremap <leader>b :BLines<CR>
" t = buffers
nnoremap <leader>t :Buf<CR>

" Quick-save and prettier
map <leader>w :Neoformat \| w<CR>
