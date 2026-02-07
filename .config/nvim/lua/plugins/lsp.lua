return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Global settings for all LSP servers
        ["*"] = {
          keys = {
            { "<C-k>", false, mode = "i" },
            { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature Help", mode = "n" },
          },
        },

        -- Lua language server
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },

        -- Go language server
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              staticcheck = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              completeUnimported = true, -- automatically import packages called but not imported
            },
          },
        },
      },
    },
  },
}
