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

-- Kill to end of line (Emacs-style) (But I think I still want digraphs?)
-- vim.keymap.set("i", "<C-k>", "<C-o>D", { desc = "Kill to end of line" })
