local M = { 'javiorfo/nvim-soil', config = function ()
	require("soil").setup({
		puml_jar = "/Users/irinanita/.local/bin/plantuml.jar",

		execute_to_open = function(img) 
            return "open " .. img
        end
	})
end
} 

return M

