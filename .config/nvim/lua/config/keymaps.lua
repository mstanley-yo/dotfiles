-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Emacs-style insert-mode navigation
vim.keymap.set("i", "<C-f>", "<Right>", { desc = "Forward one character" })
vim.keymap.set("i", "<C-b>", "<Left>", { desc = "Backward one character" })
vim.keymap.set("i", "<C-a>", "<Home>", { desc = "Beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "End of line" })
vim.keymap.set("i", "<C-p>", "<Up>", { desc = "Previous line" })
vim.keymap.set("i", "<C-n>", "<Down>", { desc = "Next line" })

-- Restore default Vim "s" (substitute)
vim.keymap.set("n", "s", "s", { noremap = true })

-- Set <C-c> to <Esc> in normal mode so you don't get the warning message to exit nvim
vim.keymap.set("n", "<C-c>", "<Esc>", { noremap = true, silent = true })

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

-- Show diagnostics in a float
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics in float" })

-- g" as an operator to surround with quotes
local function surround_with_quotes()
  vim.o.operatorfunc = "v:lua.SurroundQuotes"
  return "g@"
end
-- The actual function that does the surrounding
function _G.SurroundQuotes()
  -- Get the marks that define the operated text
  local start_pos = vim.api.nvim_buf_get_mark(0, "[")
  local end_pos = vim.api.nvim_buf_get_mark(0, "]")
  -- Get the text in the range
  local lines = vim.api.nvim_buf_get_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2] + 1, {})
  -- Handle single line case
  if #lines == 1 then
    lines[1] = '"' .. lines[1] .. '"'
  else
    -- Handle multi-line case
    lines[1] = '"' .. lines[1]
    lines[#lines] = lines[#lines] .. '"'
  end
  -- Replace the text with surrounded version
  vim.api.nvim_buf_set_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2] + 1, lines)
end
-- Map g" to use our operator in normal mode
vim.keymap.set("n", 'g"', surround_with_quotes, { expr = true, noremap = true, desc = "Surround with quotes" })
-- Map g" in visual mode to surround selection
vim.keymap.set("x", 'g"', function()
  -- Get the visual selection range
  local start_pos = vim.api.nvim_buf_get_mark(0, "<")
  local end_pos = vim.api.nvim_buf_get_mark(0, ">")
  -- Get the selected text
  local lines = vim.api.nvim_buf_get_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2] + 1, {})
  -- Surround the text
  if #lines == 1 then
    lines[1] = '"' .. lines[1] .. '"'
  else
    lines[1] = '"' .. lines[1]
    lines[#lines] = lines[#lines] .. '"'
  end
  -- Replace the selection
  vim.api.nvim_buf_set_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2] + 1, lines)
end, { noremap = true, desc = "Surround selection with quotes" })
