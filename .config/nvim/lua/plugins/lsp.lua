return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Apply to all LSP servers including pyright
        ["*"] = {
          keys = {
            -- Disable <C-k> in insert mode for signature help
            { "<C-k>", false, mode = "i" },
            -- Add <C-k> in normal mode for signature help
            { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature Help", mode = "n" },
          },
        },
      },
    },
  },
}
