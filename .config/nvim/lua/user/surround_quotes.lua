local M = {}

-- Function to surround text with quotes
local function surround_with_quotes(start_pos, end_pos)
  local start_row, start_col = start_pos[1], start_pos[2]
  local end_row, end_col = end_pos[1], end_pos[2]

  -- Get the lines
  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

  if #lines == 0 then
    return
  end

  if #lines == 1 then
    -- Single line: insert quotes at start and end
    local line = lines[1]
    local new_line = line:sub(1, start_col)
      .. '"'
      .. line:sub(start_col + 1, end_col + 1)
      .. '"'
      .. line:sub(end_col + 2)
    vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, false, { new_line })
  else
    -- Multiple lines: add quote at start of first line and end of last line
    lines[1] = lines[1]:sub(1, start_col) .. '"' .. lines[1]:sub(start_col + 1)
    lines[#lines] = lines[#lines]:sub(1, end_col + 1) .. '"' .. lines[#lines]:sub(end_col + 2)
    vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, false, lines)
  end
end

-- Operator function for normal mode (e.g., g"iw, g"ap)
function M.surround_operator(motion)
  vim.o.operatorfunc = "v:lua.require'user.surround_quotes'.operator_callback"
  return "g@"
end

-- Callback for operator mode
function M.operator_callback()
  local start_pos = vim.api.nvim_buf_get_mark(0, "[")
  local end_pos = vim.api.nvim_buf_get_mark(0, "]")
  surround_with_quotes(start_pos, end_pos)
end

-- Function for visual mode
function M.visual()
  -- Get the visual mode type BEFORE exiting visual mode
  local mode = vim.fn.mode()

  -- Get the visual selection positions BEFORE exiting visual mode
  local start_pos = vim.fn.getpos("v") -- Start of visual selection
  local end_pos = vim.fn.getpos(".") -- Current cursor position (end of selection)

  -- Exit visual mode
  vim.cmd("normal! \\<Esc>")

  -- Extract row and column (getpos returns [bufnum, lnum, col, off])
  local start_row, start_col = start_pos[2], start_pos[3] - 1
  local end_row, end_col = end_pos[2], end_pos[3] - 1

  -- Make sure start comes before end
  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, end_row = end_row, start_row
    start_col, end_col = end_col, start_col
  end

  -- For linewise visual mode, extend to cover the entire lines
  if mode == "V" then
    start_col = 0
    local last_line_tbl = vim.api.nvim_buf_get_lines(0, end_row - 1, end_row, false)
    if #last_line_tbl > 0 then
      end_col = #last_line_tbl[1] - 1
    else
      end_col = 0
    end
  end

  surround_with_quotes({ start_row, start_col }, { end_row, end_col })
end

return M
