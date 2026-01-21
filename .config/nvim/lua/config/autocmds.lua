-- Custom digraphs
vim.cmd("digraph ok 9989") -- ✅
vim.cmd("digraph no 10060") -- ❌
vim.cmd("digraph dl 128229") -- 📥

-- Autocmds for Python
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.colorcolumn = "80,100"
    vim.keymap.set("n", "<leader>r", require("user.run_python_in_tmux").run_python_in_tmux, {
      desc = "Run Python in tmux pane",
      buffer = true,
    })
  end,
})

-- Autocmd for R
vim.api.nvim_create_autocmd("FileType", {
  pattern = "r",
  callback = function()
    vim.keymap.set("n", "<leader>r", require("user.run_r_in_tmux").run_r_in_tmux, {
      desc = "Run R script in tmux pane",
      buffer = true,
    })
  end,
})
