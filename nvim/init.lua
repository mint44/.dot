-- -- Add noinsert/noselect (needed for chat autocompletion on <0.11)
-- -- and add popup when available (best experience on 0.11+).
-- local opts = { "menu", "menuone", "noinsert", "noselect" }
-- if vim.fn.has("nvim-0.11") == 1 then
-- 	table.insert(opts, "popup")
-- endk
-- vim.opt.completeopt = opts

-- Basic Neovim settings
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 4 -- Tab width
vim.opt.shiftwidth = 4 -- Indent width
vim.opt.expandtab = true -- Spaces instead of tabs
vim.opt.mouse = "a" -- Enable mouse
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.termguicolors = true -- True color support

-- Map space as leader key
vim.g.mapleader = " "

-- Keymaps
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- print("🎉 Fresh Neovim is ready!")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	-- UI basics
	spec = {

		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = require("config.lualine"), -- loads the file above
			install = { colorscheme = { "habamax" } },
			checker = { enabled = true },
		},
		{ "nvim-tree/nvim-web-devicons", lazy = true },

		{
			"stevearc/oil.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for icons
			config = require("config.oil"),
		},

		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = require("config.treesitter"),
		},
		-- Fuzzy find
		{ "nvim-lua/plenary.nvim" },

		{
			"nvim-telescope/telescope.nvim",
			branch = "0.1.x",
			config = require("config.telescope"),
		},
		{ "folke/which-key.nvim", config = require("config.which-key") },

		{
			"sainnhe/gruvbox-material",
			lazy = false,
			priority = 1000,
			config = function()
				-- Optionally configure and load the colorscheme
				-- directly inside the plugin declaration.
				vim.g.gruvbox_material_enable_italic = true
				vim.o.background = "dark"
				vim.g.gruvbox_material_background = "hard"
				vim.cmd.colorscheme("gruvbox-material")
				-- vim.o mean set option
				-- vim.g mean set global variable
			end,
		},

		{
			"github/copilot.vim",
			lazy = false,
			init = function()
				vim.g.copilot_no_tab_map = true
				vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
			end,
		},

		{
			"CopilotC-Nvim/CopilotChat.nvim",
			dependencies = {
				{ "nvim-lua/plenary.nvim", branch = "master" },
			},
			build = "make tiktoken",
			opts = {
				-- See Configuration section for options
			},
			config = require("config.copilotchat"),
		},

		-- Formatting
		{
			"stevearc/conform.nvim",
			opts = {
				format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					-- json = { "jq" },
					-- cpp = { "clang-format" },
					markdown = { "prettier" },
					yaml = { "prettier" },
				},
			},
		},

		{
			"hrsh7th/nvim-cmp",
			dependencies = { "hrsh7th/cmp-path" },
			config = function()
				local cmp = require("cmp")
				cmp.setup({
					sources = {
						{ name = "path" }, -- file path completion
						{ name = "buffer" },
					},
					mapping = cmp.mapping.preset.insert({
						["<C-y>"] = cmp.mapping.confirm({ select = true }), -- accept suggestion
						["<C-space>"] = cmp.mapping.complete(), -- manually trigger
						["<C-e>"] = cmp.mapping.abort(), -- close completion menu
						["<CR>"] = cmp.mapping.confirm({ select = false }), -- Enter also accepts if menu is open
					}),
				})
			end,
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- customize
-- local oil_open = false
-- but the vsplit should be only 20%

vim.keymap.set("n", "<C-n>", function()
	-- Check if Oil is already open
	local oil_buf = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
		if ft == "oil" then
			oil_buf = buf
			break
		end
	end

	if oil_buf then
		-- Oil is open → close its window
		vim.cmd("bd" .. oil_buf)
	else
		-- Oil is closed → open in vertical split at 20% width
		vim.cmd("topleft vsplit")
		vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.2))
		require("oil").open()
	end
end, { desc = "Toggle Oil sidebar" })

--
-- when in normal mode ctrl h and ctrl l to move beetween splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Put this in your init.lua or a Lua config file
vim.keymap.set("n", "<F5>", function()
	local file = vim.fn.expand("%:p")
	local output = vim.fn.expand("%:p:r")
	vim.cmd("w")
	vim.cmd("belowright split | terminal g++ -std=c++17 -Wall -O2 " .. file .. " -o " .. output .. " && " .. output)
	vim.cmd("startinsert")
end, { noremap = true, silent = true })
