-- ~/.config/nvim/lua/config/treesitter.lua
return function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "lua", "vim", "vimdoc", "bash", "python", "json", "yaml",
      "markdown", "markdown_inline", "cpp", "cmake"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false, -- disable old regex highlighting
    },
    indent = {
      enable = true
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",       -- start selection
        node_incremental = "<CR>",     -- expand to next node
        scope_incremental = "<S-CR>",  -- expand to scope
        node_decremental = "<BS>",     -- shrink
      },
    },
  })
end

