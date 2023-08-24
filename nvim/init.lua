require("irina.plugins-setup")
require("irina.core.keymaps")
require("irina.core.options")
require("irina.core.colorscheme")
require("irina.plugins.comment")
require("irina.plugins.nvim-tree")
require("irina.plugins.lualine")
require("irina.plugins.telescope")
require("irina.plugins.nvim-cmp")
require("irina.plugins.lsp.mason")
require("irina.plugins.lsp.lspsaga")
require("irina.plugins.lsp.lspconfig")
require("irina.plugins.lsp.null-ls")
require("irina.plugins.autopairs")
require("irina.plugins.treesitter")
require("irina.plugins.gitsigns")
require("irina.plugins.rust-tools")
require("irina.plugins.opts")
-- require("irina.plugins.todo-comments")

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
    virtual_text = true,
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- g:rustfmt_autosave = 1

