-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.opt.relativenumber = true

-- Remove auto comment on newline
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove "c"
    vim.opt.formatoptions:remove "r"
    vim.opt.formatoptions:remove "o"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    require("cmp").setup.buffer {
      sources = {
        { name = "vim-dadbod-completion" },
      },
    }
  end,
})

vim.g.nvimtree_side = "right"

vim.g.startup_bookmarks = {
  ["Q"] = "~/.config/nvim/lua/custom/plugins.lua ",
  ["I"] = "~/.config/fish/config.fish ",
}
