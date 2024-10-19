require("irina.core.keymaps");
require("irina.core.opts");

-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0

-- -- ========================================================================== --
-- -- ==                           EDITOR SETTINGS                            == --
-- -- ========================================================================== --

vim.opt.number = true
-- vim.opt.mouse = 'a'
-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true
-- vim.opt.hlsearch = false
-- vim.opt.wrap = true
-- vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.expandtab = false

-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

local group = vim.api.nvim_create_augroup('user_cmds', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'man' },
  group = group,
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})


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
  {'shaunsingh/nord.nvim', name = 'nord', priority = 1000},
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'EdenEast/nightfox.nvim', name = 'nightfox', priority = 1000 },
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true},
  {'rebelot/kanagawa.nvim', name = 'kanagawa', priority = 1000},
  { "rose-pine/neovim", name = "rose-pine", priority = 1000 },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require 'nordic' .load()
    end
  },
  { import = 'irina.plugins.basics' },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('neoconf').setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "dockerls",
          "clangd",
          "jdtls",
        },
        automatic_installation = true,
      })
    end,
    dependencies = {
      'folke/neoconf.nvim',
    },
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
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
      dependencies = { "catppuccin", "lewis6991/gitsigns.nvim" },
      config = function()
        require("irina/scripts/lspsaga").setup()
      end,
    },
      -- clangd extensions (such as inlay hints)
  {
    "p00f/clangd_extensions.nvim",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("irina/scripts/clangd").setup()
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

---
-- Colorscheme
---
require('catppuccin').setup {
  color_overrides = {
    mocha = {
      base = "#151619",
      mantle = "#151619",
      crust = "#151619",
	  teal = "#f5c2e7",
	  sky = "#f5c2e7",
	  sapphire = "#f5c2e7"
    },
  },
  transparent_background = true,
  custom_highlights = function(colors)
    return {
      Comment = { fg = colors.subtext0 },
      ["@constant.builtin"] = { fg = colors.rosewater, style = {} },
      ["@comment"] = { fg = colors.subtext0, style = { "italic" } },
    }
  end,
}

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

require('gruvbox').setup({
	transparent_mode = true,

	palette_overrides = {
          dark0 = '#282828',
          dark1 = '#3c3836',
          dark2 = '#504945',
          dark3 = '#665c54',
          dark4 = '#7c6f64',
          light0 = '#fbf1c7',
          light1 = '#f4e8be',
          light2 = '#f2e5bc',
          light3 = '#eee0b7',
          light4 = '#e5d5ad',
          bright_red = '#ea6962',
          bright_green = '#a9b665',
          bright_yellow = '#d8a657',
          bright_blue = '#7daea3',
          bright_purple = '#d3869b',
          bright_aqua = '#89b482',
          bright_orange = '#e78a4e',
          neutral_red = '#cc241d',
          neutral_green = '#98971a',
          neutral_yellow = '#d79921',
          neutral_blue = '#458588',
          neutral_purple = '#b16286',
          neutral_aqua = '#689d6a',
          neutral_orange = '#d65d0e',
          dark_red = '#722529',
          dark_green = '#62693e',
          dark_aqua = '#49503b',
          gray = '#928374',
          faded_red = '#c14a4a',
          faded_green = '#6c782e',
          faded_yellow = '#647109',
          faded_blue = '#45707a',
          faded_purple = '#945e80',
          faded_aqua = '#4c7a5d',
          faded_orange = "#c35e0a",
          light_red = "#ae5858",
          light_green = "#ebeabc",
          light_aqua = "#dee2b6",
        }
 })

-- vim.g.nord_disable_background = true
-- vim.g.nord_italic = false

require('nightfox').setup({
	options = {
		transparent = true  
	},
    groups = {
	  all = {
	    NormalFloat = { bg = "NONE" },
	  }
    }
})

require("rose-pine").setup({
    variant = "main", -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = false,

    enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
    },

    styles = {
        bold = true,
        italic = true,
        transparency = true,
    }
})

require('kanagawa').setup({
	transparent = true
})

vim.o.background = "dark" -- or "light" for light mode
vim.cmd[[colorscheme nightfox]]
-- vim.cmd[[colorscheme kanagawa-dragon]]

-- vim.cmd[[colorscheme catppuccin-mocha]]
