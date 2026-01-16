return {
  "jpalardy/vim-slime",
  config = function()
    vim.g.slime_target = "tmux"
    vim.g.slime_default_config = {
      socket_name = "default",
      target_pane = "{right-of}",
    }
    vim.g.slime_dont_ask_default = 1
  end,
  keys = {
    { "<leader>R", "<Plug>SlimeRegionSend", mode = "v", desc = "Send selection to REPL" },
    { "<leader>R", "<Plug>SlimeLineSend", mode = "n", desc = "Send line to REPL" },
  },
}
