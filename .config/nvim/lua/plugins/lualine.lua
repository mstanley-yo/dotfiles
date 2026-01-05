return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Remove everything on the right
    opts.sections.lualine_y = {}
    opts.sections.lualine_z = {}
  end,
}
