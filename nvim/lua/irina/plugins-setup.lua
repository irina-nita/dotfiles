local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
 
local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  use("nvim-lua/plenary.nvim")

  use("catppuccin/nvim")

  use("bluz71/vim-nightfly-guicolors")

  use("christoomey/vim-tmux-navigator")

  use("szw/vim-maximizer")
  
  use("tpope/vim-surround")
  use("vim-scripts/ReplaceWithRegister")
  -- COMMENTS
  use("numToStr/Comment.nvim")
    
  use("voldikss/vim-floaterm")

  use("puremourning/vimspector")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  -- icons for file
  use("kyazdani42/nvim-web-devicons")
  use ("lervag/vimtex")
  
  use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup { 
      }
      end
  })

  use ('mfussenegger/nvim-jdtls');
  use({
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
	require("trouble").setup {

      }
      end
})


  --statusline
  use("nvim-lualine/lualine.nvim")

  --fuzzy finding
  use({"nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({"nvim-telescope/telescope.nvim", branch = "0.1.x"})
  
 -- Autocompletion framework
  use("hrsh7th/nvim-cmp")
  use({
    -- cmp LSP completion
    "hrsh7th/cmp-nvim-lsp",
    -- cmp Snippet completion
    "hrsh7th/cmp-vsnip",
    -- cmp Path completion
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    after = { "hrsh7th/nvim-cmp" },
    requires = { "hrsh7th/nvim-cmp" },
  })
 
  -- snippets
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets

  --managing and installing lsp servers
  use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
  use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

 -- configuring lsp servers
  use("neovim/nvim-lspconfig") -- easily configure language servers

  -- Snippet engine
  use('hrsh7th/vim-vsnip')
  -- enhanced lsp uis
  use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)

  use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

  -- formatting & linting
  use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
  use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

  -- treesitter configuration
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  })

  use("p00f/nvim-ts-rainbow")

  -- auto closing
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

  -- git integration
  use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
  
 -- use("neovim/nvim-lspconfig") 
  use("simrat39/rust-tools.nvim")
  
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" }, 
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)



