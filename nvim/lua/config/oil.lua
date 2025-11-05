-- ~/.config/nvim/lua/config/oil.lua
return function()
	require("oil").setup({
		default_file_explorer = true, -- replace netrw; opening a dir shows Oil
		delete_to_trash = true, -- safer deletes
		skip_confirm_for_simple_edits = true,
		columns = { "icon" },
		view_options = {
			show_hidden = true,
			-- hide some noisy dirs but keep dotfiles visible
			is_always_hidden = function(name, _)
				return name == ".git" or name == "node_modules"
			end,
		},
		float = {
			padding = 2,
			max_width = 110,
			max_height = 30,
			border = "rounded",
		},
		win_options = {
			wrap = false,
			signcolumn = "no",
			cursorline = true,
		},
	})

	-- Quick access keymaps
	-- "-" opens the parent directory of the current file
	vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory (Oil)" })
	-- Floating explorer from anywhere
	vim.keymap.set("n", "<leader>e", function()
		require("oil").open_float()
	end, { desc = "File explorer (Oil float)" })
end
