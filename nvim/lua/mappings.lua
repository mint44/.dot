require "nvchad.mappings"

-- add yours here
-- Move between splits using Ctrl + hjkl
vim.api.nvim_set_keymap('t', '<C-h>', [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-j>', [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-k>', [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-l>', [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })


local map = vim.keymap.set
vim.api.nvim_set_keymap('n', '\\', '/', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '\\', '/', { noremap = true, silent = true })

-- Comment
map("n", "<C-\\>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<C-\\>", "gc", { desc = "toggle comment", remap = true })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- leader 1 2 3 4 to switch buffer
-- jump to tab number using bufferline

-- vim.keymap.set('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<CR>', { desc = 'BufferLineGoToBuffer 1' })
-- vim.keymap.set('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<CR>', { desc = 'BufferLineGoToBuffer 2' })
-- vim.keymap.set('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<CR>', { desc = 'BufferLineGoToBuffer 3' })
-- vim.keymap.set('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<CR>', { desc = 'BufferLineGoToBuffer 4' })
for i = 1, 9, 1 do
 vim.keymap.set("n", string.format("<leader>%s", i), function()
   vim.api.nvim_set_current_buf(vim.t.bufs[i])
 end)
end


-- auto commands
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.defer_fn(function()
      local api = require("nvim-tree.api")
      local view = require("nvim-tree.view")

      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(buf)
        if name:match("NvimTree*") then
          if not view.is_visible() then
            api.tree.toggle({ focus = false, find_file = true })
          end
          break
        end
      end
    end, 1) -- Jank defer to give lazy time to init the plugin, just 1 works for me increase as needed
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- repl keymaps
vim.keymap.set('n', '<leader>so', function()
  require('nvim-python-repl').open_repl()
end, { desc = '[R]EPL [O]pens the in a window split' })

vim.keymap.set('n', '<leader>ss', function()
  require('nvim-python-repl').send_statement_definition()
end, { desc = 'Send semantic unit to REPL' })
--
vim.keymap.set('v', '<leader>ss', function()
  require('nvim-python-repl').send_visual_to_repl()
end, { desc = 'Send visual selection to REPL' })
--
vim.keymap.set('n', '<leader>sb', function()
  require('nvim-python-repl').send_buffer_to_repl()
end, { desc = 'Send entire buffer to REPL' })



-- snip
local ls = require("luasnip")

vim.keymap.set({"i"}, "<C-Y>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-Y>", function() ls.jump( 1) end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

-- vim.keymap.set({"i", "s"}, "<C-E>", function()
-- 	if ls.choice_active() then
-- 		ls.change_choice(1)
-- 	end
-- end, {silent = true})


