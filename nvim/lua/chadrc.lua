-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "gruvbox",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
  theme_toggle = {"gruvbox", "one_light"}
}
-- M.ui.tabufline ={
--     order = {  "buffers", "tabs", "btns", "treeOffset" }
-- }

-- M.ui.tabufline = {
--   order = { "buffers", "tabs", "btns" , "treeOffset"}
-- }
--
M.ui = {
  -- statusline = { theme = 'vscode' },
  tabufline = {
    enabled = true,
    lazyload = true,
    -- order = {  "buffers", "tabs", "btns","treeOffset"},
    order = {  "buffers", "tabs", "btns"}, -- minh: i actually dont like treeoffset
    modules = nil,
  },
  hl_override = {
    Comment = { italic=true },
  }
}

M.nvdash ={
  load_on_startup = true,
}
M.mason= {
  pkgs={
    "basedpyright", "pyright", "mypy", "ruff", "black"
  }
}

return M
