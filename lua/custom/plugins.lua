local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    event = "BufWritePre",
    config = function()
      require "custom.configs.conform"
    end,
  },

  -- Custom
  {
    "tpope/vim-surround",
    lazy = false,
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = false,
  },

  {
    "numToStr/Comment.nvim",
    after = { "nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
    lazy = false,
  },

  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = false,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    --opts = overrides.copilot, -- have your own local overrided configurations in: custom/configs/overrides.lua
    config = function()
      require("copilot").setup {
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "right", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          --auto_trigger = false, -- if autocomplete menu doesn't show while you type, setting this to true is recommended
          auto_trigger = true, -- if autocomplete menu doesn't show while you type, setting this to true is recommended
          debounce = 75,
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<C-]>",
            prev = "<M-[>",
            --dismiss = "<C-]>",
            dismiss = "<C-e>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          javascript = true, -- allow specific filetype
          typescript = true, -- allow specific filetype
          ["."] = false,
          --["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
          sh = function()
            if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
              -- disable for .env files
              return false
            end
            return true
          end,
        },
        copilot_node_command = "node", -- Node.js version must be > 16.x
        server_opts_overrides = {
          trace = "verbose",
          settings = {
            advanced = {
              listCount = 6, -- #completions for panel
              inlineSuggestCount = 5, -- #completions for getCompletions
            },
          },
        },
      }
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup {
        formatters = {
          label = require("copilot_cmp.format").format_label_text,
          insert_text = require("copilot_cmp.format").format_insert_text,
          insert_text = require("copilot_cmp.format").remove_existing,
          preview = require("copilot_cmp.format").deindent,
        },
        mapping = {
          ["<CR>"] = cmp.mapping.confirm {
            -- this is the important line
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          },
        },
      }
    end,
  },

  {
    "alexghergh/nvim-tmux-navigation",
    lazy = false,
    config = function()
      local nvim_tmux_nav = require "nvim-tmux-navigation"

      nvim_tmux_nav.setup {
        disable_when_zoomed = true, -- defaults to false
      }

      vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
