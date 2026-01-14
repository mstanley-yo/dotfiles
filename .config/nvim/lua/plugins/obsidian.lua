return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "notes",
        path = "/Users/stanleyyo/Library/CloudStorage/GoogleDrive-maximilianstanleyyo1@gmail.com/My Drive/YY",
      },
    },
    disable_frontmatter = true,
    completion = {
      -- For blink.cmp, use this instead of nvim_cmp
      nvim_cmp = false,
      min_chars = 2,
    },
    templates = {
      subdir = nil,
    },
    daily_notes = {
      folder = "Journal",
      date_format = "%Y-%m-%d",
      template = nil,
    },
    footer = {
      enabled = false,
    },
  },
}
