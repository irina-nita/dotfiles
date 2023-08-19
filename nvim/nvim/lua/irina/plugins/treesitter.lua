-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

-- configure treesitter
treesitter.setup({
  -- enable syntax highlighting
  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = true,
  },
  -- enable indentation
  indent = { enable = true },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  -- ensure these language parsers are installed
  ensure_installed = {
    "c",
    "cpp",
    "arduino",
    "cmake",
    "bash",
    "dockerfile",
    "dot",
    "rust",
    "scala",
    "verilog",
  },
  -- auto install above language parsers
  auto_install = true,
  rainbow = {
    enable = true,
  },
})

