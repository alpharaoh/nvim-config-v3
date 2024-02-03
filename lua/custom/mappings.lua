---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-d>"] = { "<C-d>zz", "Center and scroll down", opts = { nowait = true } },
    ["<C-u>"] = { "<C-u>zz", "Center and scroll up", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
  },
  v = {},
  i = {
    ["kj"] = { "<Esc>", "enter visual mode", opts = { nowait = true } },
  },
}

M.telescope = {
  n = {
    ["<leader>fs"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
  },
}

M.lazygit = {
  n = {
    ["<leader>lg"] = { "<cmd> LazyGit <CR>", "Lazy git" },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<C-_>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<C-_>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>n"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}

-- more keybinds!

return M
