-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_php_lsp = "intelephense"

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.autoindent = true
vim.opt_local.smarttab = true

-- Example configuration using a list of dictionaries:
vim.g.dbs = {
    { name = "local", url = "mysql://root:R9TctcLLpdzwbM4Kxvcz@extranetlocal.bertschi.com:3307" },
    -- { name = "staging", url = "Replace with your database connection URL." },
}

vim.g.dadbod_default_connection = vim.g.dbs[1].url

if vim.env.SSH_CONNECTION then
    local function vim_paste()
        local content = vim.fn.getreg('"')
        return vim.split(content, "\n")
    end

    vim.g.clipboard = {
        name = "OSC 52",
        copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        },
        paste = {
            ["+"] = vim_paste,
            ["*"] = vim_paste,
        },
    }
end
