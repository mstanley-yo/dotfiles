-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Map leaders
vim.g.maplocalleader = "\\"
vim.g.mapleader = " "

-- Use system clipboard by default
vim.opt.clipboard = "unnamedplus"
vim.schedule(function()
  local _ = vim.fn.has("clipboard")
  -- Or alternatively:
  -- pcall(vim.fn.setreg, '+', '')
end)

-- Enable command-line completion popup
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum" -- Use popup menu for wildmenu
