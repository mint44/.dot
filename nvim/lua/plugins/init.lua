
 
return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  --
  {
    "github/copilot.vim",
    lazy = false,
  },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "configs.nvimtree"
      -- return "configs.nvimtree"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "nvchad.configs.luasnip"
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "configs.cmp"
    end,
  },

  -- null-ls
  {
    "nvimtools/none-ls.nvim",
    ft = { "python" },
    opts = function()
      return require "configs.none-ls"
    end,
  },
  -- {
  --   "vhyrro/luarocks.nvim",
  --   enable = false,
  --   lazy= true,
  --   priority = 1001, -- this plugin needs to run before anything else
  --   opts = {
  --     rocks = { "magick" },
  --   },
  -- },
  -- {
  --   "3rd/image.nvim",
  --   enable = false,
  --   lazy = true,
  --   -- dependencies = {
  --   --   "kiyoon/magick.nvim",
  --   -- },
  --   config = function()
  --     require("image").setup ({
  --         backend = "kitty",
  --         integrations = {
  --           markdown = {
  --             enabled = true,
  --             clear_in_insert_mode = false,
  --             download_remote_images = true,
  --             only_render_image_at_cursor = false,
  --             filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
  --           },
  --           neorg = {
  --             enabled = true,
  --             clear_in_insert_mode = false,
  --             download_remote_images = true,
  --             only_render_image_at_cursor = false,
  --             filetypes = { "norg" },
  --           },
  --           html = {
  --             enabled = false,
  --           },
  --           css = {
  --             enabled = false,
  --           },
  --         },
  --         max_width = nil,
  --         max_height = nil,
  --         max_width_window_percentage = nil,
  --         max_height_window_percentage = 50,
  --         window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
  --         window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  --         editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  --         tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  --         hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
  --   })
  -- end,
  -- }
  {
    'geg2102/nvim-python-repl',
    dependencies = 'nvim-treesitter',
    ft = { 'python', 'lua', 'scala' },
    config = function()
      require('nvim-python-repl').setup {
        execute_on_send = true,
        vsplit = false,
      }
    end,
  },
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    }
  }

}
