local M = {}

function M.open_emoji_picker()
  -- Save cursor position (row, col)
  local pos = vim.api.nvim_win_get_cursor(0)
  local row, col = pos[1], pos[2]

  -- Get the current line to check if we're at the end
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
  local line_length = #line

  -- Determine if we're at the end of the line
  local at_end = col >= line_length

  -- If at end of line, insert two spaces before exiting insert mode
  if at_end then
    vim.api.nvim_put({ "  " }, "c", true, true)
  end

  -- Exit insert mode
  vim.cmd("stopinsert")

  -- Set cursor position
  vim.api.nvim_win_set_cursor(0, { row, col })

  local group = vim.api.nvim_create_augroup("EmojiPickerInsert", { clear = true })
  vim.api.nvim_create_autocmd("WinClosed", {
    group = group,
    once = true,
    callback = function()
      vim.schedule(function()
        -- If we were at end of line, delete the two spaces we added
        if at_end then
          vim.cmd("normal! xx")
          -- Use startinsert! to enter insert mode after the cursor
          vim.cmd("startinsert!")
        else
          vim.cmd("startinsert")
        end
      end)
      vim.api.nvim_del_augroup_by_id(group)
    end,
  })
  vim.cmd("InsertEmoji")
end

return M
