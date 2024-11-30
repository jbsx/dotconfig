-------------------------Editor------------------------
vim.g.mapleader = ' '
vim.keymap.set('n', 'go', vim.cmd.Ex)
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
--vim.keymap.set('i', 'jj', '<esc>')

------------------------UndoTree-----------------------
vim.keymap.set('n', '<A-u>', vim.cmd.UndotreeToggle)

-----------------------Clipboard-----------------------
vim.keymap.set({ 'n', 'x' }, '<leader>p', '\"+p')
vim.keymap.set({ 'n', 'x' }, '<leader>y', '\"+y')
vim.keymap.set({ 'n', 'x' }, '<leader>P', '\"+P')
vim.keymap.set({ 'n', 'x' }, '<leader>Y', '\"+Y')

------------------------Movement-----------------------
--vim.keymap.set({ 'n', 'x' }, '<A-j>', '<C-d>')
--vim.keymap.set({ 'n', 'x' }, '<A-k>', '<C-u>')
--vim.keymap.set({ 'n', 'x' }, '<A-h>', '^')
--vim.keymap.set({ 'n', 'x' }, '<A-l>', '$')

vim.keymap.set({ 'n', 'x' }, '<A-j>', 'J')
vim.keymap.set({ 'n', 'x' }, '<A-k>', 'K')

vim.keymap.set({ 'n', 'x' }, 'J', '<C-d>')
vim.keymap.set({ 'n', 'x' }, 'K', '<C-u>')
vim.keymap.set({ 'n', 'x' }, 'H', '^')
vim.keymap.set({ 'n', 'x' }, 'L', '$')

-----------------------Telescope-----------------------
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

---------------------File Navigation-------------------
vim.keymap.set('n', '<leader><leader>', '<C-^>')
vim.keymap.set('n', '<left>', ':bp<cr>')
vim.keymap.set('n', '<right>', ':bn<cr>')

--------------------------LSP--------------------------
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>o', vim.diagnostic.open_float)
vim.keymap.set('n', '<A-E>', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<A-e>', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<A-k>', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        --vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        --vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        --vim.keymap.set('n', '<leader>wl', function()
        --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        --end, opts)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>2', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
