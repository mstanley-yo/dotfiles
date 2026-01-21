local M = {}

function M.run_r_in_tmux()
  -- Check if running in tmux
  if not vim.env.TMUX then
    vim.notify("ERROR: This command requires tmux", vim.log.levels.ERROR)
    return
  end

  -- Check if file has name
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("ERROR: Buffer has no file name.", vim.log.levels.ERROR)
    return
  end

  vim.cmd.write()

  -- Find Rscript executable
  local rscript = "Rscript"
  if vim.fn.executable(rscript) == 0 then
    vim.notify("ERROR: Rscript not found in PATH", vim.log.levels.ERROR)
    return
  end

  -- Count tmux panes
  local pane_count = tonumber(vim.fn.system("tmux list-panes | wc -l"))
  if pane_count == 1 then
    vim.fn.system([[tmux split-window -h -p 40 -c "#{pane_current_path}"]])
    vim.fn.system("tmux select-pane -t :.+")
  end

  local r_cmd = rscript .. " " .. vim.fn.shellescape(file)
  vim.fn.system("tmux send-keys -t ':.+' " .. vim.fn.shellescape(r_cmd) .. " Enter")
end

return M
