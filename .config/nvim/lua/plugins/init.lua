return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
  	"williamboman/mason.nvim",
  	opts = {
      ensure_installed = {
        "lua-language-server",
        "terraform-ls",
        "tflint",
        -- "rust_analyzer"
     },

      PATH = "skip",

      ui = {
        icons = {
          package_pending = " ",
          package_installed = "󰄳 ",
          package_uninstalled = " 󰚌",
        },

        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },
      },

      max_concurrent_installers = 10,
  	},
  },

  {
    "nvim-treesitter/nvim-treesitter",
    -- init = function()
    --   require("core.utils").lazy_load "nvim-treesitter"
    -- end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function()
      require "configs.treesitter"
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require "configs.indent-blankline"
    end
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "configs.nvim-tree"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Telescope",
    config = function()
      require "configs.telescope"
    end,
  },

  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`", "c", "v", "g" },
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },

  {
    "hashivim/vim-terraform",
    ft = "terraform"
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },

    init = function()
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
    end,
  },

  {
    "charludo/projectmgr.nvim",
    lazy = false,
  },

  -- no idea why this is needed
  -- load luasnips + cmp related in insert mode only
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   dependencies = {
  --     {
  --       -- snippet plugin
  --       "L3MON4D3/LuaSnip",
  --       dependencies = "rafamadriz/friendly-snippets",
  --       opts = { history = true, updateevents = "TextChanged,TextChangedI" },
  --       config = function(_, opts)
  --         require("plugins.configs.others").luasnip(opts)
  --       end,
  --     },

  --     -- autopairing of (){}[] etc
  --     {
  --       "windwp/nvim-autopairs",
  --       opts = {
  --         fast_wrap = {},
  --         disable_filetype = { "TelescopePrompt", "vim" },
  --       },
  --       config = function(_, opts)
  --         require("nvim-autopairs").setup(opts)

  --         -- setup cmp for autopairs
  --         local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  --         require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  --       end,
  --     },

  --     -- cmp sources plugins
  --     {
  --       "saadparwaiz1/cmp_luasnip",
  --       "hrsh7th/cmp-nvim-lua",
  --       "hrsh7th/cmp-nvim-lsp",
  --       "hrsh7th/cmp-buffer",
  --       "hrsh7th/cmp-path",
  --     },
  --   },
  --   opts = function()
  --     return require "plugins.configs.cmp"
  --   end,
  --   config = function(_, opts)
  --     require("cmp").setup(opts)
  --   end,
  -- },

  -- this doesn't work and i need to fix
  --  {
  --   "lewis6991/gitsigns.nvim",
  --   ft = { "gitcommit", "diff" },
  --   init = function()
  --     -- load gitsigns only when a git file is opened
  --     vim.api.nvim_create_autocmd({ "BufRead" }, {
  --       group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
  --       callback = function()
  --         vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
  --         if vim.v.shell_error == 0 then
  --           vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
  --           vim.schedule(function()
  --             require("lazy").load { plugins = { "gitsigns.nvim" } }
  --           end)
  --         end
  --       end,
  --     })
  --   end,
  --   opts = {
  --     signs = {
  --       add = { text = "│" },
  --       change = { text = "│" },
  --       delete = { text = "󰍵" },
  --       topdelete = { text = "‾" },
  --       changedelete = { text = "~" },
  --       untracked = { text = "│" },
  --     },
  --     on_attach = function(bufnr)
  --       utils.load_mappings("gitsigns", { buffer = bufnr })
  --     end,
  --   },
  --   config = function(_, opts)
  --     require("gitsigns").setup(opts)
  --   end,
  -- },
}
