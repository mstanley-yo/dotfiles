return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",

  opts = {
    ensure_installed = {
      "go",
      "gomod",
      "gosum",
      "bash",
      "yaml",
      "json",
      "dockerfile",
      "markdown",
      "markdown_inline",
      "r",
      "latex",
      "csv",
    },

    highlight = {
      enable = true,
    },
  },
}
