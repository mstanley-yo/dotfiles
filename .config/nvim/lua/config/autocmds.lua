-- Custom digraphs
vim.cmd("digraph ok 9989") -- ✅
vim.cmd("digraph no 10060") -- ❌

-- Bindings to open a new line below while keeping cursor on current line
vim.keymap.set("n", "go", "o<Esc>k", { noremap = true })
vim.keymap.set("n", "gO", "O<Esc>j", { noremap = true })

-- Bind BS to destructive d (while supporting motions)
vim.keymap.set({ "n", "v" }, "<BS>", '"_d', { noremap = true, silent = true })

-- Run Python file in next tmux pane.
vim.keymap.set("n", "<leader>r", function()
  -- Check if running in tmux
  if vim.env.TMUX == nil then
    vim.notify("ERROR: This command requires tmux", vim.log.levels.ERROR)
    return
  end
  -- Check if file has name
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("ERROR: Buffer has no file name.", vim.log.levels.ERROR)
    return
  end
  vim.cmd("write") -- Save the file first
  -- Try to find venv python, fall back to system python
  local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
  if vim.fn.executable(venv_python) == 0 then
    venv_python = "/Users/stanleyyo/Python/.venv/bin/python"
  end
  if vim.fn.executable(venv_python) == 0 then
    venv_python = "python3" -- Fallback to system python
  end
  -- Check if there's more than one pane
  local pane_count = tonumber(vim.fn.system("tmux list-panes | wc -l"))
  -- If only one pane, create a second one and switch back
  if pane_count == 1 then
    vim.fn.system('tmux split-window -h -p 40 -c "#{pane_current_path}"')
    vim.fn.system("tmux select-pane -t :.+") -- Switch back to the original pane
  end
  -- Send command to the next pane
  local python_cmd = venv_python .. " " .. vim.fn.shellescape(file)
  vim.fn.system("tmux send-keys -t ':.+' " .. vim.fn.shellescape(python_cmd) .. " Enter")
end, { desc = "Run with Python in tmux pane" })

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
