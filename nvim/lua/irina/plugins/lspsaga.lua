local M = { 'nvimdev/lspsaga.nvim' , config = function ()
    require('lspsaga').setup({
        -- keybinds for navigation in lspsaga window
        scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
        -- use enter to open file with definition preview
        definition = {
          edit = "<CR>",
        },
        ui = {
          colors = {
            normal_bg = "#022746",
          },
          code_action = '🚀',
        },
      })
end}

return M
