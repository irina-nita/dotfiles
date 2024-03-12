local M = {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        'williamboman/mason.nvim'
    },
    config = function()
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                "clangd",
                "arduino_language_server",
                "bashls",
                "dockerls",
                "docker_compose_language_service",
                "jdtls",
                "rust_analyzer",
                "svlangserver",
                "pyright",
                "jsonls",
            },
            automatic_installation = true,
        })
    end
}

local P = {
    'jay-babu/mason-null-ls.nvim',
    dependencies = {
        'williamboman/mason.nvim'
    },
    config = function()
        require('mason').setup()
        require('mason-null-ls').setup({
            automatic_installation = true,
        })
    end
}

return { M, P }
