-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Custom digraphs
vim.cmd("digraph ok 9989") -- ✅

-- Function to open a new line below while keeping cursor on current line
vim.keymap.set("n", "<C-o>", "mzo<Esc>`z", { noremap = true, silent = true })

-- Use system clipboard by default
vim.opt.clipboard = "unnamedplus"
