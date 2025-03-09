require("irina.core.keymaps");
require("irina.core.opts");

-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})
local group = vim.api.nvim_create_augroup('user_cmds', { clear = true })

--
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   desc = 'Highlight on yank',
--   group = group,
--   callback = function()
--     vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
--   end,
-- })
--
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'help', 'man' },
--   group = group,
--   command = 'nnoremap <buffer> q <cmd>quit<cr>'
-- })


-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Color theme
  -- oxocarbon
  { "nyoom-engineering/oxocarbon.nvim", name = "oxocarbon", priority = 1000 },
  { "ramojus/mellifluous.nvim", name = "mellifluous", priority = 1000,
    config = function()
        require("mellifluous").setup({})
    end
  },
  -- zenbones
  {
        "zenbones-theme/zenbones.nvim",
        -- Optionally install Lush. Allows for more configuration or extending the colorscheme
        -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
        -- In Vim, compat mode is turned on as Lush only works in Neovim.
        dependencies = "rktjmp/lush.nvim",
        lazy = false,
        priority = 1000,
        -- you can set set configuration options here
        -- config = function()
        --     vim.g.zenbones_darken_comments = 45
        --     vim.cmd.colorscheme('zenbones')
        -- end
  },
  {
    "kvrohit/rasmus.nvim",
    priority = 1000,
    config = function()
        -- vim.cmd([[colorscheme rasmus]])
    end,
  },
  -- kanagawa 
  {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        -- you can set set configuration options here
        config = function()
            require('kanagawa').setup({
                commentStyle = { italic = false },
                -- transparent = false,
                colors = {
                    theme = {
                        dragon  = {
                            ui = {
                                bg_gutter = "none"
                            }
                        }
                    }
                },
                overrides = function(colors)
                    return {
                        -- Keyword = { italic = false },
                        -- Label = { italic = false },
                    }
		end,
        })
        end
  },
  { import = 'irina.plugins.basics' },
  -- Code completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "f3fora/cmp-spell",
      "L3mon4d3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
      "p00f/clangd_extensions.nvim",
    },
    config = function()
      require("irina/scripts/cmp").setup()
    end,
  },
  -- Resize windows
  { "anuvyklack/windows.nvim",
    dependencies = { "anuvyklack/middleclass" },
    config = function()
        require('windows').setup()
    end
  },
  -- Code snippets
  {
    "L3mon4d3/LuaSnip",
    config = function()
      require("irina/scripts/luasnip").setup()
    end,
  },
  -- Configs for the built-in Language Server Protocol
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mfussenegger/nvim-jdtls", "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim" },
    config = function()
      require("irina/scripts/lspconfig").setup()
    end,
  },
    -- Lsp additions
    {
      "glepnir/lspsaga.nvim",
      branch = "main",
      dependencies = { "lewis6991/gitsigns.nvim" },
      config = function()
        require("irina/scripts/lspsaga").setup()
      end,
    },
  -- Tresitter for minimal syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
	  dependencies = {
	    "neovim/nvim-lspconfig"
	  },
    build = ":TSUpdate",
    config = function()
      require("irina/scripts/treesitter").setup()
    end,
    lazy = false
  },
  { import = "irina.plugins.rustvim" },
  { import = "irina.plugins.tree" },
  { import = "irina.plugins.comments" },
  { import = "irina.plugins.lualine" },
  { import = "irina.plugins.soil" },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   ---@module "ibl"
  --   ---@type ibl.config
  --   opts = {},
  --   config = function ()
  --       require("ibl").setup()
  --   end
  -- },
	-- install with yarn or npm
  {
   "iamcco/markdown-preview.nvim",
   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
   build = "cd app && npm install",
   init = function()
    vim.g.mkdp_filetypes = { "markdown" }
   end,
   ft = { "markdown" },
  },
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

local telescope = require('telescope')
local actions = require('telescope.actions')

-- configure telescope
telescope.setup()
telescope.load_extension("fzf")

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

------------------------------------------------------------------
----------------------------- THEMES -----------------------------  
-----------------------------------------------------------------

-- vim.termguicolors = true
vim.g.seoulbones_lighten_line_nr = 10 
vim.g.seoulbones_transparent_background = true
vim.g.seoulbones_italic_comments = true

vim.o.background = "dark" -- or "light" for light mode
vim.cmd("colorscheme kanagawa-dragon")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatermBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeBorder" , { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeTitle" , { bg = "none" })

--
-- -- ========================================================================== --
-- -- ==                           EDITOR SETTINGS                            == --
-- -- ========================================================================== --

vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.showtabline = 2
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = true
