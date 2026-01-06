return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    -- Ensure sources table exists
    opts.sources = opts.sources or {}

    -- Configure providers with per-filetype settings
    opts.sources.providers = opts.sources.providers or {}

    -- Disable buffer source for markdown files
    opts.sources.providers.buffer = {
      enabled = function()
        return vim.bo.filetype ~= "markdown"
      end,
    }

    return opts
  end,
}
