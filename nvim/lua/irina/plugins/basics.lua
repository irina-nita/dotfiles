return {
    -- Icons
    { 'kyazdani42/nvim-web-devicons', name = 'devicons' },
    -- FloaTerm
    { 'voldikss/vim-floaterm' },
    -- Dashboard
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup({
                theme = 'hyper',
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                        {
                            icon = ' ',
                            icon_hl = '@variable',
                            desc = 'Files',
                            group = 'Label',
                            action = 'Telescope find_files',
                            key = 'f',
                        },
                        {
                            desc = ' Apps',
                            group = 'DiagnosticHint',
                            action = 'Telescope app',
                            key = 'a',
                        },
                        {
                            desc = ' dotfiles',
                            group = 'Number',
                            action = 'Telescope dotfiles',
                            key = 'd',
                        },
                    },
                },
            })
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	-- TODOs
	{
  		"folke/todo-comments.nvim",
  		dependencies = { "nvim-lua/plenary.nvim" },
  		opts = {
    		-- your configuration comes here
    		-- or leave it empty to use the default settings
    		-- refer to the configuration section below
  		}
	},
}

