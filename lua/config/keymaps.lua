-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "i", "v", "c" }, "fj", "<Esc>", { desc = "Map Caps Lock to Escape" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "p", [["_dP]], { desc = "Paste without yank" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
