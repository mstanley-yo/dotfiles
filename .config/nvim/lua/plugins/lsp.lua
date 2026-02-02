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

        -- R language server
        r_language_server = {
          cmd = { "R", "--slave", "-e", "languageserver::run()" },
          filetypes = { "r", "rmd" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(".git", ".Rproj", "DESCRIPTION")(fname) or vim.fn.getcwd()
          end,
          settings = {
            r = {
              lsp = {
                rich_documentation = true,
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
