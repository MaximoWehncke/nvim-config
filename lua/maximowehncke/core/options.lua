vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- NOTE: fixing tree sitter some how si making auto-folds. this disables it
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs display
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = false -- USE TABS, NOT SPACES
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- disable mouse
-- opt.mouse = ""

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow bacjspace on indent, end of line, or insert mode start position

--clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as deafult register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false
