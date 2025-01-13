local null_ls = require("null-ls")

local ops = {
  sources = {
    -- null_ls.builtins.diagnostics.mypy,
    -- null_ls.builtins.diagnostics.ruff, -- not supported yet in none-ls
    null_ls.builtins.formatting.black,
  }
}

return ops
