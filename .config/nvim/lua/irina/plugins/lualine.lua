-- -- LuaLine
-- {
--    'nvim-lualine/lualine.nvim',
--    dependencies = { 'nvim-tree/nvim-web-devicons' }
-- }

local M = { 'nvim-lualine/lualine.nvim' , config = function ()
    require('lualine').setup({
		options = {
        theme = "auto",
		-- ... the rest of your lualine config
		tabline = {
		  lualine_a = {},
		  lualine_b = {'branch'},
		  lualine_c = {'filename'},
		  lualine_x = {},
		  lualine_y = {},
		  lualine_z = {}
		}	
    	}
      })
end
}

return M

