return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "/Users/stanleyyo/Library/CloudStorage/GoogleDrive-maximilianstanleyyo1@gmail.com/My Drive/YY",
      },
    },
  },
}
