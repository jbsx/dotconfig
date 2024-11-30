vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
        [".*"] = {
            cmdline  = "neovim",
            content  = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never"
        },
        ["https?://leetcode.com/"] = {
            takeover = "always"
        }
    }
}

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = { "leetcode.com_*.txt" },
    callback = function()
        vim.opt.filetype = "python"
        vim.cmd("colorscheme gruvbox")
    end
})
