-- -- LuaLine
-- {
--    'nvim-lualine/lualine.nvim',
--    dependencies = { 'nvim-tree/nvim-web-devicons' }
-- }

local M = { 'nvim-lualine/lualine.nvim' , config = function ()
    require('lualine').setup({
	    options = {
            always_show_tabline = true,
            theme = "auto",
            component_separators = { left = '|', right = '|'},
            section_separators = { left = '', right = ''},
            -- ... the rest of your lualine config
            tabline = {
              lualine_a = {'buffers'},
              lualine_b = {'branch'},
              lualine_c = {'filename'},
              lualine_x = {},
              lualine_y = {},
              lualine_z = {'tabs'}
            },
        }
    })
end
}

return M

