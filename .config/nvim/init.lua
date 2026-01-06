-- Use system clipboard by default
vim.opt.clipboard = "unnamedplus"
vim.schedule(function()
  local _ = vim.fn.has("clipboard")
  -- Or alternatively:
  -- pcall(vim.fn.setreg, '+', '')
end)

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
