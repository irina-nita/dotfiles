local M = {}

local util = require("lspconfig.util")

local function on_attach(client, bufnr)
    -- empty for now
end

function M.setup()
    vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local mason_registry = require("mason-registry")

    -- Clangd
    local clangd_executable = vim.fn.glob(mason_registry.get_package("clangd"):get_install_path() .. "/clangd_*")
        .. "/bin/clangd"

    print(clangd_executable)

    lspconfig.clangd.setup({
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        -- cmd = {
        --     clangd_executable,
        --     "--query-driver=/**/*",
        --     "--clang-tidy",
        --     "--header-insertion=never",
        --     "--offset-encoding=utf-16",
        -- },
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            require("clangd_extensions.inlay_hints").setup_autocmd()
            require("clangd_extensions.inlay_hints").set_inlay_hints()
        end,
        autostart = true,
    })

	lspconfig.denols.setup {
	  on_attach = on_attach,
	  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc", "_package.json"),
	}

	lspconfig.tsserver.setup {
	  on_attach = on_attach,
	  root_dir = lspconfig.util.root_pattern("package.json"),
	  single_file_support = false
	}

    -- Rust analyzer
    lspconfig.rust_analyzer.setup {
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
        filetypes = { 'rust' }, autostart = true
    }

	-- Gleam LSP
	lspconfig.gleam.setup {}
	lspconfig.pyright.setup {}
--	lsp.clangd.setup {}
end

return M
