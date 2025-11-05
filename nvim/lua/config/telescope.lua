
-- ~/.config/nvim/lua/config/telescope.lua
return function()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      prompt_prefix = "  ",
      selection_caret = "➤ ",
      path_display = { "smart" },
      mappings = {
        i = {
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<Esc>"] = actions.close,
        },
      },
      file_ignore_patterns = { "%.git/", "node_modules/", "build/", "dist/" },
      layout_config = { horizontal = { preview_width = 0.55 }, width = 0.66, height = 0.62 },
      sorting_strategy = "ascending",
      -- set to true if you want to include dotfiles in find_files
      -- follow symlinks can be added: find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }
    },
    pickers = {
      find_files = { hidden = true },
      live_grep = { additional_args = function() return { "--hidden", "--glob", "!.git/*" } end },
      buffers = { sort_mru = true, ignore_current_buffer = true },
      lsp_references = { show_line = false },
    },
    extensions = {
      fzf = { fuzzy = true, case_mode = "smart_case" },
    },
  })

  pcall(telescope.load_extension, "fzf")

  -- keymaps
  local map = vim.keymap.set
  map("n", "<leader><leader>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
  map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",  { desc = "Grep text" })
  map("n", "<leader>fb", "<cmd>Telescope buffers<CR>",    { desc = "Buffers" })
  map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>",  { desc = "Help tags" })
  map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>",   { desc = "Recent files" })
  map("n", "gd", "<cmd>Telescope lsp_definitions<CR>",    { desc = "LSP definitions" })
  map("n", "gr", "<cmd>Telescope lsp_references<CR>",     { desc = "LSP references" })
end
