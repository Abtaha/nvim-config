-- Auto-install Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "plugins.colorscheme" },
	{ import = "plugins.lualine" },
	{ import = "plugins.telescope" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.lsp" },
	{ import = "plugins.completion" },
	{ import = "plugins.whichkey" },
	{ import = "plugins.supermaven" },
	{ import = "plugins.dev-icons" },
	{ import = "plugins.tree" },
	{ import = "plugins.noice" },
	{ import = "plugins.splash" },
	{ import = "plugins.formatter" },
	{ import = "plugins.comments" },
})
