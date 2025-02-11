local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "c",
      "cpp",
      "cmake",
      "bash",
      "dockerfile",
      "html",
      "java",
      "javascript",
      "json",
      "kotlin",
      "latex",
      "llvm",
      "lua",
      "make",
      "markdown",
      "proto",
      "python",
      "regex",
      "ruby",
      "rust",
      "typescript",
      "vim",
    },
    -- sync_install = false,
    highlight = {
        enable = true,
        disable = { "latex", },
    },
    -- indent = { enable = true },
    -- autotag = { enable = true },
    -- auto_install = true,
    -- rainbow = {
    --     enable = true
    -- },
    lazy = false
  })
end

return M
