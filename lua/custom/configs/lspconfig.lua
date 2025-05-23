local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "ts_ls", "graphql", "eslint", "clangd", "tailwindcss", "prismals", "pyright" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
      preferences = {
        -- Will use the import alias set in tsconfig.json for auto imports
        importModuleSpecifierPreference = "non-relative"
      }
    }
  }
end
