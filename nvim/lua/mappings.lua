require "nvchad.mappings"
-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")


-- python debug
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "set breakpoint" })
map("n", "<leader>dpr", function()
  require("dap-python").test_method()
end, { desc = "debug run" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
--
--
--

local dap = require('dap')

-- Set up a keybinding to start debugging the current file
vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F9>', '<cmd>DapToggleBreakpoint<CR>', { noremap = true, silent = true })

-- Optional: Add keybindings for other DAP actions
vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })

-- Add a configuration for running the current Python file
dap.configurations.python = {
  {
    type = 'python',  -- The type of configuration (defined in dap-python)
    request = 'launch',
    name = "Launch file",
    program = "${file}",  -- The current file will be run
    pythonPath = function()
      return vim.fn.exepath('python')  -- Uses the active Python environment
    end,
  },
}


dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = false,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false 
      },
    },
    miDebuggerPath = '/usr/bin/gdb', -- Adjust this path based on your system
    miDebuggerArgs = '',
    externalConsole = true,
  },
}

-- add common key mappings for neovim
map("n", "<leader>q", "<cmd>q<CR>", { desc = "quit" })
map("n", "<leader>Q", "<cmd>q!<CR>", { desc = "force quit" })




