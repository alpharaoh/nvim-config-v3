--type conform.options
local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },

    javascript = { "custom_prettier" },
    javascriptreact = { "custom_prettier" },
    typescript = { "custom_prettier" },
    typescriptreact = { "custom_prettier" },
    css = { "custom_prettier" },
    html = { "custom_prettier" },
    graphql = { "custom_prettier" },

    sh = { "shfmt" },
  },
  formatters = {
    custom_prettier = {
      command = "/usr/local/bin/prettierd",
      args = { "$FILENAME" },
      cwd = require("conform.util").root_file { ".prettierrc", "package.json" },
      stdin = true,
    },
  },

  -- adding same formatter for multiple filetypes can look too much work for some
  -- instead of the above code you could just use a loop! the config is just a table after all!

  format_after_save = {
    lsp_fallback = true,
  },
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
