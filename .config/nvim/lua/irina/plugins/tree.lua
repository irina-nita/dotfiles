vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local TR = {
    'nvim-tree/nvim-tree.lua',
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	},
    config = function()
		-- local devicons = require('nvim-web-devicons')
		-- devicons.setup({
		-- 	override_by_filename = {
		-- 		[".toml"] = {
		-- 			icon = "PL",
		-- 			color = "#f1502f",
		-- 		}
		-- 	};
		-- })
        local tree = require('nvim-tree')
        tree.setup({
			-- icons = {
			-- 		web_devicons = {
			-- 			file = {
			-- 			  enable = true,
			-- 			  color = true,
			-- 			},
			-- 			folder = {
			-- 			  enable = false,
			-- 			  color = false,
			-- 			},
			-- },
            -- change folder arrow icons
            renderer = {
				icons = {
                    glyphs = {
                        folder = {
                            -- arrow_closed = "->", -- arrow when folder is closed
                            -- arrow_open = "↓", -- arrow when folder is open
							-- default = "♥",
							-- color = false
                        },
						git = {
							-- unstaged = "󰊠",
    						staged = "󰇥",
    						-- unmerged = "UM",
    						-- renamed = "R",
    						-- deleted = "D",
    						untracked = "",
    						ignored = "",
						},
                    },
					show = {
						-- folder = false
					},
					web_devicons = {
						folder = {
							-- enable = true,
							color = false
						}
					}
                },
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            git = {
                ignore = false
            }
        })
    end
}

return TR
