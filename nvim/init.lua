vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- add path
--
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.local/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.local/share/lua/5.1/?.lua"


-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.keymap.set("n", "<F5>", function()
  local file = vim.fn.expand("%")
  local ext = vim.fn.expand("%:e")
  local output = "/tmp/a.out"

  if ext == "cpp" then
    vim.cmd("split | terminal g++ " .. file .. " -o " .. output .. " && " .. output)
  elseif ext == "c" then
    vim.cmd("split | terminal gcc " .. file .. " -o " .. output .. " && " .. output)
  elseif ext == "py" then
    vim.cmd("split | terminal python3 " .. file)
  else
    print("No run command for ." .. ext)
  end
end, { desc = "Compile and run current file in terminal" })
