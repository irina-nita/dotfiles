local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
        "PaterJason/cmp-conjure",
		"hrsh7th/vim-vsnip",
		-- "p00f/clangd_extensions.nvim",
		"onsails/lspkind.nvim",
		"rafamadriz/friendly-snippets",
		"rcarriga/cmp-dap",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		{
			"L3mon4d3/LuaSnip",
			config = function()
				require("luasnip/loaders/from_vscode").lazy_load()
			end,
		},
	},
}

vim.opt.completeopt = { "menu", "menuone", "noselect" }

M.config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local lspkind = require("lspkind")

	local select_opts = { behavior = cmp.SelectBehavior.Select }

	cmp.setup({
		preselect = cmp.PreselectMode.None,
		snippet = {
			expand = function(args)
				-- vim.fn["vsnip#anonymous"](args.body)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			-- Add tab support
			["<S-Tab>"] = cmp.mapping.select_prev_item(),
			["<Tab>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
		},

		-- Installed sources
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "vsnip" },
			{ name = "path" },
			{ name = "buffer" },
		}),
		sorting = {
			comparators = {
				require("clangd_extensions.cmp_scores"),
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.locality,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			}
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		formatting = {
			format = lspkind.cmp_format({
			  mode = "symbol_text",
			  max_width = 100,
			  menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[Latex]",
			  },
			}),
		  },
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

return M
