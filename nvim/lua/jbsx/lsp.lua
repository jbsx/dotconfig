local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.pyright.setup{capabilities = capabilities}
lspconfig.tsserver.setup{capabilities = capabilities}
lspconfig.rust_analyzer.setup{capabilities = capabilities}
lspconfig.gopls.setup{capabilities = capabilities}
lspconfig.svelte.setup{capabilities = capabilities}
lspconfig.clangd.setup{capabilities = capabilities}
lspconfig.cssls.setup{capabilities = capabilities}
lspconfig.lua_ls.setup{capabilities = capabilities}
lspconfig.svelte.setup{capabilities = capabilities}
lspconfig.jsonls.setup {capabilities = capabilities}
lspconfig.prismals.setup{capabilities = capabilities}
lspconfig.html.setup {capabilities = capabilities}
lspconfig.solidity.setup{capabilities = capabilities}
lspconfig.texlab.setup{capabilities = capabilities}
lspconfig.astro.setup({
capabilities = capabilities,
  init_options = {
    typescript = {
      tsdk = vim.fs.normalize('/usr/lib/node_modules/typescript/lib')
    }
  },
})
