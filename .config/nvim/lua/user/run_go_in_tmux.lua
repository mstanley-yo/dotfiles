local M = {}

local function ensure_tmux()
  if not vim.env.TMUX then
    vim.notify("ERROR: This command requires tmux", vim.log.levels.ERROR)
    return false
  end
  return true
end

local function ensure_file()
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("ERROR: Buffer has no file name.", vim.log.levels.ERROR)
    return nil
  end
  return file
end

local function prepare_tmux(file_dir)
  -- Save buffer
  vim.cmd.write()

  -- Count panes
  local pane_count = tonumber(vim.fn.system("tmux list-panes | wc -l"))

  if pane_count == 1 then
    vim.fn.system([[tmux split-window -h -p 40 -c "]] .. file_dir .. [["]])
    vim.fn.system("tmux select-pane -t :.+")
  end
end

local function send_cmd(cmd)
  vim.fn.system("tmux send-keys -t ':.+' " .. vim.fn.shellescape(cmd) .. " Enter")
end

-- Run current file: go run main.go
function M.run_go_file()
  if not ensure_tmux() then
    return
  end

  local file = ensure_file()
  if not file then
    return
  end

  local file_dir = vim.fn.expand("%:p:h")
  local filename = vim.fn.expand("%:t")

  prepare_tmux(file_dir)

  local go_cmd = "cd " .. vim.fn.shellescape(file_dir) .. " && go run " .. vim.fn.shellescape(filename)

  send_cmd(go_cmd)
end

-- Run package: go run .
function M.run_go_package()
  if not ensure_tmux() then
    return
  end

  local file = ensure_file()
  if not file then
    return
  end

  local file_dir = vim.fn.expand("%:p:h")

  prepare_tmux(file_dir)

  local go_cmd = "cd " .. vim.fn.shellescape(file_dir) .. " && go run ."

  send_cmd(go_cmd)
end

return M
