local M = {}
function M.run_go_in_tmux()
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
  -- Get the directory of the current file
  local file_dir = vim.fn.expand("%:p:h")

  -- Count tmux panes
  local pane_count = tonumber(vim.fn.system("tmux list-panes | wc -l"))
  if pane_count == 1 then
    vim.fn.system([[tmux split-window -h -p 40 -c "]] .. file_dir .. [["]])
    vim.fn.system("tmux select-pane -t :.+")
  end

  -- Change to the file's directory and run go run .
  local go_cmd = "cd " .. vim.fn.shellescape(file_dir) .. " && go run ."
  vim.fn.system("tmux send-keys -t ':.+' " .. vim.fn.shellescape(go_cmd) .. " Enter")
end
return M
