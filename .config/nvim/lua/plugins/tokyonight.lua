return {
  "folke/tokyonight.nvim",
  opts = {
    on_highlights = function(hl, c)
      -- Use TokyoNight's bright colors
      hl.MoreMsg = { fg = c.fg, bold = true } -- Use the theme's foreground
      hl.MsgArea = { fg = c.fg }
    end,
  },
}
