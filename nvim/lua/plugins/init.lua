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
  {
    "nvimtools/none-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "configs.null-ls"
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
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies={
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts={
      handlers = {},
      ensure_installed ={
      }

    }
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function(_, opts)
      local venv_path = vim.fn.exepath("python")
      -- #local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(venv_path)
    end,
  },
  {
    "github/copilot.vim",
    lazy=false,
  },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   config = function(_, opts)
  --     opts.sources[#opts.sources + 1] = { name = "codeium" }
  --     require("cmp").setup(opts)
  --   end,
  -- },
  -- {
  --   "Exafunction/codeium.nvim",
  --   lazy=false,
  --   dependencies = {
  --       "nvim-lua/plenary.nvim",
  --       "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --       require("codeium").setup({
  --       })
  --   end
  -- },
}
