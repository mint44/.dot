return function()
	local wk = require("which-key")

	wk.setup({
		win = { border = "rounded" },
		plugins = {
			marks = true,
			registers = true,
			spelling = { enabled = true, suggestions = 20 },
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
	})

	-- Use the new flat spec with `wk.add`
	wk.add({
		-- Top-level groups
		{ "<leader>f", group = "Find" },
		{ "<leader>g", group = "Git" },
		{ "<leader>l", group = "LSP" },

		-- General
		{ "<leader>e", "<cmd>Oil<CR>", desc = "File Explorer" },
		{ "<leader>q", "<cmd>q<CR>", desc = "Quit" },
		{ "<leader>w", "<cmd>w<CR>", desc = "Save" },

		-- Find (Telescope)
		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent Files" },

		-- Git (gitsigns)
		{ "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", desc = "Stage Hunk" },
		{ "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset Hunk" },
		{ "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview Hunk" },

		-- LSP
		{
			"<leader>la",
			function()
				vim.lsp.buf.code_action()
			end,
			desc = "Code Action",
		},
		{
			"<leader>lr",
			function()
				vim.lsp.buf.rename()
			end,
			desc = "Rename",
		},
		{ "<leader>ld", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
	}, {
		mode = "n", -- normal-mode mappings
		silent = true,
		noremap = true,
	})

	wk.add({
		{ "<leader>c", group = "Copilot" },
		{ "<leader>cc", "<cmd>CopilotChat<CR>", desc = "Open Chat" },
		{ "<leader>ce", "<cmd>CopilotChatExplain<CR>", desc = "Explain Code" },
		{ "<leader>cf", "<cmd>CopilotChatFix<CR>", desc = "Fix Code" },
		{ "<leader>co", "<cmd>CopilotChatOptimize<CR>", desc = "Optimize Code" },
		{ "<leader>ct", "<cmd>CopilotChatTests<CR>", desc = "Generate Tests" },
	})
end
