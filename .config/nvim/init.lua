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
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
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
      base = "#121212",
      mantle = "#121212",
      crust = "#121212",
    },
  },
  transparent_background = true,
  custom_highlights = function(colors)
    return {
      Comment = { fg = colors.subtext0 },
      ["@constant.builtin"] = { fg = colors.rosewater, style = {} },
      ["@comment"] = { fg = colors.teal, style = { "italic" } },
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

-- ---
-- -- lualine.nvim (statusline)
-- ---
-- vim.opt.showmode = false
-- require('lualine').setup({
--   options = {
--     icons_enabled = false,
--     component_separators = '|',
--     section_separators = '',
--   },
-- })

vim.cmd.colorscheme('catppuccin')
