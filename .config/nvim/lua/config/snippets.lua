require("luasnip.loaders.from_vscode").lazy_load({
  paths = { vim.fn.expand("~/.config/nvim/snippets") },
})
