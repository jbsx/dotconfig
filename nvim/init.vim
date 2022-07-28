set shell=/bin/bash
call plug#begin('~/.config/nvim/plugged')

" Nvim configuration
Plug 'tpope/vim-sensible'
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'sbdchd/neoformat'

" Syntax
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Autocomplete
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'

call plug#end()

" Colorscheme
let base16colorspace=256
colorscheme base16-gruvbox-dark-hard

"For Types hint 
hi default CocRustTypeHint ctermbg=0 ctermfg=DarkGray
"Others hint 
hi default CocRustChainingHint ctermbg=0 ctermfg=DarkGray


" Autocomplete
set completeopt=menu,menuone,noselect

lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' },
      }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
EOF

syntax enable
filetype plugin indent on

set number relativenumber
set mouse=a
set cursorline


let mapleader = "\<Space>"

inoremap jj <esc>
nnoremap <leader><leader> <c-^>
inoremap <esc> <C-o>:echo "NO ESAPCE FOR YOU"<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
