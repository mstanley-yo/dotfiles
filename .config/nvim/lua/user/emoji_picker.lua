local M = {}

function M.open_emoji_picker()
  vim.cmd("stopinsert")
  vim.cmd("normal! l")
  vim.cmd("InsertEmoji")
  vim.defer_fn(function()
    vim.api.nvim_feedkeys("i", "n", false)
  end, 10)
end

return M
