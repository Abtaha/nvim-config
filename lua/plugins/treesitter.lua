return {
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
			},
			highlight = {
				enable = true, -- Enable syntax highlighting
				additional_vim_regex_highlighting = false, -- Disable Vim's default regex highlighting
			},
			indent = {
				enable = true, -- Enable smart indentation
			},
			incremental_selection = {
				enable = true, -- Enable incremental selection
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			rainbow = {
				enable = true, -- Enable rainbow parentheses
				extended_mode = true, -- Enable rainbow for more filetypes
				max_file_lines = 1000, -- Limit for enabling rainbow for large files
			},
			autotag = {
				enable = true, -- Enable auto-closing and renaming of HTML/JSX tags
			},
		})
	end,
}
