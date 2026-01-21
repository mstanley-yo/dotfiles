return {
  "R-nvim/R.nvim",
  lazy = false,
  build = function()
    vim.fn.system("git -C " .. vim.fn.stdpath("data") .. "/lazy/R.nvim submodule update --init --recursive")
  end,
  config = function()
    local opts = {
      R_args = { "--quiet", "--no-save" },
      external_term = "tmux split-window -h -p 40",
      hook = {
        after_R_start = function()
          -- Switch back to the previous pane after R starts
          vim.fn.system("tmux select-pane -l")
        end,
      },
    }
    require("r").setup(opts)
  end,
}
