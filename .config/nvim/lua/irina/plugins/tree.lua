vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local TR = {
    'nvim-tree/nvim-tree.lua',
    config = function()
        local tree = require('nvim-tree')
        tree.setup({
            -- change folder arrow icons
            renderer = {
                icons = {
                    glyphs = {
                        folder = {
                            arrow_closed = "->", -- arrow when folder is closed
                            arrow_open = "↓", -- arrow when folder is open
                            default = "♥",
                        },
                    },
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
