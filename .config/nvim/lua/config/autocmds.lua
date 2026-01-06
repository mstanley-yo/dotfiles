-- Custom digraphs
vim.cmd("digraph ok 9989") -- ✅
vim.cmd("digraph no 10060") -- ❌

-- Bindings to open a new line below while keeping cursor on current line
vim.keymap.set("n", "go", "o<Esc>k", { noremap = true })
vim.keymap.set("n", "gO", "O<Esc>j", { noremap = true })

-- Bind BS to destructive d (while supporting motions)
vim.keymap.set({ "n", "v" }, "<BS>", '"_d', { noremap = true, silent = true })

-- Run current file with Python venv (auto-save first)
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("write") -- Save the file first
  local file = vim.fn.expand("%:p")
  -- Try to find venv python, fall back to system python
  local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
  if vim.fn.executable(venv_python) == 0 then
    venv_python = "/Users/stanleyyo/Python/.venv/bin/python"
  end
  if vim.fn.executable(venv_python) == 0 then
    venv_python = "python3" -- Fallback to system python
  end
  vim.api.nvim_feedkeys(":!" .. venv_python .. " " .. file .. "\n", "n", false)
end, { desc = "Run current file with Python (venv)" })

-- Ruler for python
vim.opt.colorcolumn = "80,100"

-- Bindings for obsidian
vim.keymap.set("n", "<leader>o", function()
  vim.cmd("edit " .. os.date(os.getenv("YY") .. "/Journal/%Y-%m-%d.md"))
end, { desc = "Open daily note" })
vim.keymap.set("n", "<leader>O", function()
  -- ensure we're in a markdown buffer
  if vim.bo.filetype ~= "markdown" then
    vim.cmd("enew")
    vim.bo.filetype = "markdown"
  end
  vim.cmd("Obsidian")
end, { desc = "Open Obsidian command" })
