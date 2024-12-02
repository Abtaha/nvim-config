-- Basic settings
local opt = vim.opt

-- Set leader key
vim.g.mapleader = " " -- Spacebar as leader key

-- Basic UI settings
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.cursorline = true -- Highlight the current line
opt.wrap = false -- Disable line wrapping
opt.scrolloff = 8 -- Keep 8 lines visible when scrolling

-- Tabs and indentation
opt.tabstop = 4 -- Number of spaces per tab
opt.shiftwidth = 4 -- Number of spaces for indentation
opt.expandtab = true -- Convert tabs to spaces
opt.smartindent = true -- Smart indentation

-- Searching
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true -- Override ignorecase if search has uppercase
opt.incsearch = true -- Show search matches as you type

-- Clipboard
opt.clipboard = "unnamedplus" -- Use system clipboard

-- Better splits
opt.splitright = true -- Vertical split opens to the right
opt.splitbelow = true -- Horizontal split opens below

-- Performance
opt.updatetime = 300 -- Faster completion (default is 4000ms)
opt.timeoutlen = 500 -- Faster key mappings

-- General indentation settings (for most languages)
opt.tabstop = 2 -- Number of spaces a tab counts for
opt.shiftwidth = 2 -- Number of spaces for indentation
opt.expandtab = true -- Convert tabs to spaces
opt.smartindent = true -- Smart indentation
opt.softtabstop = 2 -- Make 'Tab' key insert 2 spaces

opt.termguicolors = true
