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
vim.cmd("digraph no 10060") -- ❌

-- Function to open a new line below while keeping cursor on current line
vim.keymap.set("n", "go", "o<Esc>k", { noremap = true })
vim.keymap.set("n", "gO", "O<Esc>j", { noremap = true })

-- Use system clipboard by default
vim.opt.clipboard = "unnamedplus"

-- Bind BS to destructive d (while supporting motions)
vim.keymap.set({ "n", "v" }, "<BS>", '"_d', { noremap = true, silent = true })

-- Run current file with Python (auto-save first)
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("write")
  local file = vim.fn.expand("%")
  vim.api.nvim_feedkeys(":!python3 " .. file .. "\n", "n", false)
end, { desc = "Run current file with Python" })
