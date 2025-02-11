local M = {}

function M.setup()
  require("luasnip.loaders.from_vscode").lazy_load({
    override_priority = 99999,
    paths = { vim.fn.stdpath("config") .. "/snippets" },
  })
end

return M
