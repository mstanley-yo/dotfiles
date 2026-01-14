return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        enabled = false, -- Go straight to empty buffer when launching nvim
      },
      image = {
        resolve = function(path, src)
          local api = require("obsidian.api")
          if api.path_is_note(path) then
            return api.resolve_attachment_path(src)
          end
        end,
      },
    },
  },
}
