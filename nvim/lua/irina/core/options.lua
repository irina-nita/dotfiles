local opt = vim.opt --for concisness

--line numbers
opt.relativenumber = true
opt.number = true

--tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

--line wrapping
opt.wrap = true

--search settings
opt.ignorecase = true
opt.smartcase = true

--cursor line
opt.cursorline = true

-- appearance
--opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

--baskspace
opt.backspace = "indent,eol,start"

--clipboardoa
opt.clipboard:append("unnamedplus")

--split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

