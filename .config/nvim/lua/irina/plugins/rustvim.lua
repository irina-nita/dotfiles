local function on_attach(client, buffer)
    -- This callback is called when the LSP is atttached/enabled for this buffer
    -- we could set keymaps related to LSP, etc here.
end

local opts = {
    tools = {
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            auto = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
        },
    },
    server = {
        on_attach = on_attach,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                }
            },
        },
    },
}

return {
    {
        'rust-lang/rust.vim',
        ft = 'rust',
        init = function()
            vim.g.rustfmt_autosave = 0
        end
    },
    {
        'simrat39/rust-tools.nvim',
        ft = 'rust',
        opts = opts
    },
    {
        'mfussenegger/nvim-dap'
    }
}
