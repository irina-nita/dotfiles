require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "mocha",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
   -- no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = { "bold" },
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {
        mocha = {
            base = "#121212",
            mantle = "#121212",
            crust = "#121212",
        },
    },
    custom_highlights = function(colors)
        return {
            Comment = { fg = colors.subtext0 },
            ["@constant.builtin"] = { fg = colors.rosewater, style = {} },
            ["@comment"] = { fg = colors.teal, style = { "italic" } },
        }
    end
    ,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        aerial = true,
        barbar = true,
    },
})

vim.cmd("colorscheme catppuccin")
