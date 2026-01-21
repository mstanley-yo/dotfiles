return {
  "R-nvim/R.nvim",
  ft = { "r", "rmd", "quarto" }, -- load only for R files
  build = function()
    vim.fn.system("git -C " .. vim.fn.stdpath("data") .. "/lazy/R.nvim submodule update --init --recursive")
  end,
  config = function()
    local opts = {
      R_args = { "--quiet", "--no-save" },
      external_term = "tmux split-window -h -p 40",
      r_ls = {
        completion = true, -- enable the completion provider
        hover = true, -- enable the hover provider
        signature = true, -- enable the signature help provider
        doc_width = 0,

        -- List of functions that get column name completion.
        -- Can't do wildcards for some reason, so here goes a stupid long list.
        -- Maybe I am doomed to just use RStudio...
        fun_data_1 = {
          -- dplyr / tidyverse core
          "select",
          "rename",
          "rename_with",
          "mutate",
          "transmute",
          "filter",
          "slice",
          "arrange",
          "summarise",
          "summarize",
          "reframe",
          "group_by",
          "ungroup",
          "count",
          "add_count",
          "distinct",
          "pull",
          "across",
          "if_any",
          "if_all",
          "rowwise",

          -- joins
          "left_join",
          "right_join",
          "inner_join",
          "full_join",
          "semi_join",
          "anti_join",

          -- tidyr
          "pivot_longer",
          "pivot_wider",
          "separate",
          "separate_rows",
          "unite",
          "nest",
          "unnest",
          "unnest_longer",
          "unnest_wider",
          "drop_na",
          "replace_na",
          "fill",

          -- purrr-ish data masking usage
          "map",
          "map_dbl",
          "map_int",
          "map_chr",
          "map_lgl",
          "pmap",
          "imap",
          "walk",

          -- base R summaries (intentionally included)
          "mean",
          "median",
          "sd",
          "var",
          "sum",
          "min",
          "max",
          "quantile",
          "IQR",
          "length",
          "nrow",
          "ncol",
          "cor",
          "cov",
          "scale",

          -- stats / modeling
          "lm",
          "glm",
          "aov",
          "predict",
          "fitted",
          "residuals",
          "update",
          "anova",

          -- broom-style
          "tidy",
          "glance",
          "augment",

          -- ggplot helpers (top-level)
          "ggplot",
          "labs",
          "theme",
          "theme_bw",
          "theme_minimal",
          "xlab",
          "ylab",
          "facet_wrap",
          "facet_grid",

          -- misc data workflows
          "with",
          "within",
          "subset",
          "transform",

          -- data.table-adjacent habits (even if not strict)
          "setorder",
          "setnames",

          -- generic / user-defined friendliness
          "plot",
          "print",
          "summary",
          "head",
          "tail",
          "View",
        },
        fun_data_2 = { ggplot = { "aes" }, with = { "*" } }, -- List of nested functions that get column name completions
        fun_data_formula = { ggplot = { "facet_wrap", "facet_grid", "vars" } },
        quarto_intel = nil,
      },
      -- Disable insert-mode pipe helper (<LocalLeader>,)
      disable_cmds = {
        "RInsertPipe",
      },
      hook = {
        after_R_start = function()
          -- Switch back to the previous pane after R starts
          vim.fn.system("tmux select-pane -l")
        end,
      },
    }
    require("r").setup(opts)
  end,
}
