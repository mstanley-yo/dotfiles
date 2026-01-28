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

-- Autocmds for R
vim.api.nvim_create_autocmd("FileType", {
  pattern = "r",
  callback = function()
    vim.keymap.set("n", "<leader>R", "<LocalLeader>rf", {
      desc = "Start R in tmux pane",
      buffer = true,
      remap = true,
    })
    vim.keymap.set("n", "<leader>r", "<LocalLeader>d", {
      desc = "Send line to R",
      buffer = true,
      remap = true,
    })
    -- Use C-p for pipe
    vim.keymap.set("i", "<C-p>", " |> ", {
      desc = "Insert pipe operator",
      buffer = true,
      noremap = true,
      silent = true,
    })
  end,
})

-- Autocmd for Go
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(args)
    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format()
      end,
    })

    -- Keymap to run Go in tmux
    vim.keymap.set("n", "<leader>r", require("user.run_go_in_tmux").run_go_in_tmux, {
      desc = "Run Go in tmux pane",
      buffer = args.buf,
    })
  end,
})
