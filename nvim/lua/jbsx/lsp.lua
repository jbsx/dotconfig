local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('pyright', { capabilities = capabilities })
vim.lsp.config('gopls', { capabilities = capabilities })
vim.lsp.config('svelte', { capabilities = capabilities })
vim.lsp.config('clangd', { capabilities = capabilities })
vim.lsp.config('cssls', { capabilities = capabilities })
vim.lsp.config('lua_ls', { capabilities = capabilities })
vim.lsp.config('jsonls', { capabilities = capabilities })
vim.lsp.config('prismals', { capabilities = capabilities })
vim.lsp.config('html', { capabilities = capabilities })
vim.lsp.config('solidity', { capabilities = capabilities })
vim.lsp.config('texlab', { capabilities = capabilities })

vim.lsp.config('ts_ls', {
  capabilities = capabilities,
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
  cmd = { 'typescript-language-server', '--stdio' },
})

vim.lsp.config('rust_analyzer', {
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      cargo = { features = 'all' },
    },
  },
})

vim.lsp.config('astro', {
  capabilities = capabilities,
  init_options = {
    typescript = {
      tsdk = vim.fs.normalize('/usr/lib/node_modules/typescript/lib'),
    },
  },
})

vim.lsp.enable({
  'pyright', 'ts_ls', 'rust_analyzer', 'gopls', 'svelte', 'clangd',
  'cssls', 'lua_ls', 'jsonls', 'prismals', 'html', 'solidity', 'texlab', 'astro'
})
