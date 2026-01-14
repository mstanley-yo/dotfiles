local M = {}

function M.run_python_in_tmux()
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

  -- Find python executable
  local cwd = vim.fn.getcwd()
  local venv_python = cwd .. "/.venv/bin/python"

  if vim.fn.executable(venv_python) == 0 then
    venv_python = vim.fn.expand("~/Python/.venv/bin/python")
  end

  if vim.fn.executable(venv_python) == 0 then
    venv_python = "python3"
  end

  -- Count tmux panes
  local pane_count = tonumber(vim.fn.system("tmux list-panes | wc -l"))

  if pane_count == 1 then
    vim.fn.system([[tmux split-window -h -p 40 -c "#{pane_current_path}"]])
    vim.fn.system("tmux select-pane -t :.+")
  end

  local python_cmd = venv_python .. " " .. vim.fn.shellescape(file)
  vim.fn.system("tmux send-keys -t ':.+' " .. vim.fn.shellescape(python_cmd) .. " Enter")
end

return M
