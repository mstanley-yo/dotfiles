-- Autocmds for Python
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.colorcolumn = "80,100"
    vim.keymap.set("n", "<leader>r", require("user.python_tmux").run_python_file, {
      desc = "Run Python in tmux pane",
      buffer = true,
    })
  end,
})

-- Autocmd for Go
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(args)
    -- Format on save (using gofumpt by lsp)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format()
      end,
    })

    -- Keymaps to run Go in tmux
    local go = require("user.go_tmux")
    vim.keymap.set("n", "<leader>r", go.run_go_file, {
      desc = "Go: Run current file in tmux",
      buffer = args.buf,
    })

    vim.keymap.set("n", "<leader>R", go.run_go_package, {
      buffer = true,
      desc = "Go: Build and run package in tmux",
    })
  end,
})

-- Autocmd for markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(event)
    vim.keymap.set("n", "<leader>O", function()
      vim.cmd("Obsidian")
    end, {
      buffer = event.buf,
      desc = "Open Obsidian command",
    })
  end,
})
