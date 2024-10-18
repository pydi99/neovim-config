return {
  {
    "nvim-tree/nvim-tree.lua",

    opts = {
      -- view = {
      --   width = 30,
      --   side = "right",
      -- },
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Copy default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Map 'tt' for moving files to trash
        vim.keymap.set("n", "tt", function()
          local node = api.tree.get_node_under_cursor()
          if node and node.fs_stat then
            vim.fn.system { "gio", "trash", node.absolute_path } -- Move to trash
            api.tree.reload() -- Reload the tree after moving
          end
        end, opts "Move to trash")

        -- Map 'bb' for moving bookmarked files to trash
        vim.keymap.set("n", "bb", function()
          local bookmarks = api.tree.get_bookmarked_nodes()
          for _, node in ipairs(bookmarks) do
            vim.fn.system { "gio", "trash", node.absolute_path } -- Move to trash
          end
          api.tree.reload() -- Reload the tree after moving
        end, opts "Move bookmarked to trash")
        -- Other custom mappings can go here
      end,
    },
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
      require("todo-comments").setup {
        keywords = {
          FIX = {
            icon = " ",
            color = "#DC2626", -- Change to a red color
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          TODO = { icon = " ", color = "#FFFFFF" }, -- Change to a green color
          HACK = { icon = " ", color = "#FFFF00" }, -- Change to a yellow color
          WARN = { icon = " ", color = "#f36700", alt = { "WARNING", "XXX" } }, -- Change to orange
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "#65FE08", alt = { "INFO" } }, -- Change to blue
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } }, -- Change to purple
          GROUP = { icon = " ", color = "hint" },
          HERE = { icon = " ", color = "here" },
        },
        colors = {
          here = "#fdf5a4", -- Existing color for HERE
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#f36700" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" },
        },
        highlight = { multiline = true },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    config = function()
      require("nvim-ts-autotag").setup()
      -- code
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "go",
        "rust",
        "markdown",
      },
      highlight = {
        enable = true,
      },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Localstorage/obsidian-notes/",
        },
        {
          name = "work",
          path = "~/Localstorage/obsidian-notes/",
        },
      },

      -- see below for full list of options 👇
    },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}
