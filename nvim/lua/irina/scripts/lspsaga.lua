local M = {}

function M.setup()
  require("lspsaga").setup({
    symbol_in_winbar = {
      enable = false,
      separator = " ",
      hide_keyword = true,
      show_file = true,
      folder_level = 2,
    },
  })
end

return M
