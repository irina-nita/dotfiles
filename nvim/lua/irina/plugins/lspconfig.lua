local keymap = vim.keymap

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
    -- keybind options
    local opts = { noremap = true, silent = true, buffer = bufnr }
    -- set keybinds
    keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)                     -- show definition, references
    keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)          -- got to declaration
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)                -- see definition and make edits in window
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)       -- go to implementation
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)            -- see available code actions
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)                 -- smart rename
    keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)   -- show  diagnostics for line
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)           -- jump to previous diagnostic in buffer
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)           -- jump to next diagnostic in buffer
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)                       -- show documentation for what is under cursor
    keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)                 -- see outline on right hand side
end

return { {
    'neovim/nvim-lspconfig',
    name = 'lspconfig',
    dependencies = {
        {
            'folke/neoconf.nvim',
            config = function()
                require('neoconf').setup()
            end,
        },
        {
            'hrsh7th/cmp-nvim-lsp',
            name = 'cmp_nvim_lsp',
            config = function()
                require('cmp_nvim_lsp').setup()
            end
        },
        { "williamboman/mason.nvim" },
    },
    config = function()
        local lspconfig = require('lspconfig')

        -- Rust analyzer
        lspconfig['rust_analyzer'].setup {
            -- Server specific settings.
            settings = {
                ['rust-analyzer'] = {
                    cargo = {
                        allFeatures = true,
                    },
                    procMacro = {
                        enable = true
                    },
                },
            },
            filetypes = { 'rust' }
        }

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- lspconfig.verible.setup({
		-- 	cmd = {'verible-verilog-ls', '--rules_config_search'},
		-- })
    end
} }
