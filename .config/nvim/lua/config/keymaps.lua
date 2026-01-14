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
vim.keymap.set(
  "n",
  "<leader>r",
  require("user.run_python_in_tmux").run_python_in_tmux,
  { desc = "Run Python in tmux pane" }
)

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

-- Show Python diagnostics in a float
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics in float" })

-- Make g" an operator to surround with quotes
local surround = require("user.surround_quotes")
vim.keymap.set("n", 'g"', surround.surround_operator, { expr = true, noremap = true, desc = "Surround with quotes" })
vim.keymap.set("x", 'g"', function()
  surround.visual()
end, { noremap = true, desc = "Surround selection with quotes" })

-- Bind Ctlr + K to emoji picker
vim.keymap.set("i", "<C-k>", function()
  vim.cmd("InsertEmoji")
end, { desc = "Emoji picker" })
