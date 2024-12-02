-- Set leader key
vim.g.mapleader = " " -- Spacebar as leader key

-- Basic UI settings
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight the current line
vim.opt.wrap = false -- Disable line wrapping
vim.opt.scrolloff = 8 -- Keep 8 lines visible when scrolling

-- Tabs and indentation
vim.opt.tabstop = 4 -- Number of spaces per tab
vim.opt.shiftwidth = 4 -- Number of spaces for indentation
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smartindent = true -- Smart indentation

-- Searching
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- Override ignorecase if search has uppercase
vim.opt.incsearch = true -- Show search matches as you type

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Better splits
vim.opt.splitright = true -- Vertical split opens to the right
vim.opt.splitbelow = true -- Horizontal split opens below

-- Performance
vim.opt.updatetime = 300 -- Faster completion (default is 4000ms)
vim.opt.timeoutlen = 500 -- Faster key mappings

-- General indentation settings (for most languages)
vim.opt.tabstop = 2 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 2 -- Number of spaces for indentation
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smartindent = true -- Smart indentation
vim.opt.softtabstop = 2 -- Make 'Tab' key insert 2 spaces

vim.opt.termguicolors = true

-- Python-specific indentation (4 spaces)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
		vim.opt.softtabstop = 4
	end,
})

-- Auto-install Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load Lazy.nvim
require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false, -- Load immediately
		priority = 1000, -- Ensure it loads first
		opts = {}, -- Optional: Pass options here if needed
		config = function()
			vim.cmd("colorscheme tokyonight")
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {},
	},

	{
		"nvim-lualine/lualine.nvim", -- Statusline plugin
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- Icons for lualine
		config = function()
			require("lualine").setup({
				options = {
					theme = "tokyonight", -- Set the theme to tokyonight
					component_separators = "", -- Remove separators between components
					section_separators = "", -- Remove separators between sections
					disabled_filetypes = {
						"NvimTree", -- Disable on NvimTree
						"packer", -- Disable on packer
						"TelescopePrompt", -- Disable on Telescope prompt (starter page)
						"mason", -- Disable on Mason
						"aplha.nvim",
					},
					globalstatus = false, -- Set to false for per-window statusline (true would show global statusline)
				},
				sections = {
					lualine_a = { "mode" }, -- Display the mode (normal, insert, etc.)
					lualine_b = { "branch" }, -- Display git branch
					lualine_c = { "filename" }, -- Display the filename
					lualine_x = { "encoding", "fileformat", "filetype" }, -- Display encoding, fileformat, filetype
					lualine_y = { "progress" }, -- Show the progress (percentage through the file)
					lualine_z = { "location" }, -- Display the current line and column
				},
				extensions = { "nvim-tree" }, -- Add any extra extensions, such as nvim-tree
			})
		end,
	},

	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},

	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local nvimtree = require("nvim-tree")

			-- recommended settings from nvim-tree documentation
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			nvimtree.setup({
				view = {
					width = 30,
				},
				-- change folder arrow icons
				renderer = {
					indent_markers = {
						enable = true,
					},
					icons = {
						glyphs = {
							folder = {
								arrow_closed = "", -- arrow when folder is closed
								arrow_open = "", -- arrow when folder is open
							},
						},
					},
				},
				-- disable window_picker for
				-- explorer to work well with
				-- window splits
				actions = {
					open_file = {
						window_picker = {
							enable = false,
						},
					},
				},
				filters = {
					custom = { ".DS_Store" },
				},
				git = {
					ignore = false,
				},
			})

			-- set keymaps
			local keymap = vim.keymap -- for conciseness

			keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
			keymap.set(
				"n",
				"<leader>ef",
				"<cmd>NvimTreeFindFileToggle<CR>",
				{ desc = "Toggle file explorer on current file" }
			) -- toggle file explorer on current file
			keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
			keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "┊" },
		},
	},

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Set header
			dashboard.section.header.val = {
				"                                                     ",
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
				"                                                     ",
			}

			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
				dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
				dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
				dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
				dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
				dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
			}

			-- Send config to alpha
			alpha.setup(dashboard.opts)

			-- Disable folding on alpha buffer
			vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			-- import nvim-autopairs
			local autopairs = require("nvim-autopairs")

			-- configure autopairs
			autopairs.setup({
				check_ts = true, -- enable treesitter
				ts_config = {
					lua = { "string" }, -- don't add pairs in lua string treesitter nodes
					javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
					java = false, -- don't check treesitter on java
				},
			})

			-- import nvim-autopairs completion functionality
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			-- import nvim-cmp plugin (completions plugin)
			local cmp = require("cmp")

			-- make autopairs and completion work together
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = true,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},

		config = function()
			local noice = require("noice")

			noice.setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					path_display = { "smart" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},
				},
			})

			telescope.load_extension("fzf")

			-- set keymaps
			local keymap = vim.keymap -- for conciseness

			keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
			keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
			keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
			keymap.set(
				"n",
				"<leader>fc",
				"<cmd>Telescope grep_string<cr>",
				{ desc = "Find string under cursor in cwd" }
			)
		end,
	},

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},

	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					svelte = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					graphql = { "prettier" },
					liquid = { "prettier" },
					lua = { "stylua" },
					python = { "isort", "black" },
					cpp = { "clangd" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate", -- Automatically update parsers after installation
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
	},

	-- LSP Setup
	{
		"williamboman/mason.nvim", -- Manage LSP servers, linters, and formatters
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim", -- Integration with nvim-lspconfig
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"tailwindcss",
					"tsserver",
					"html",
					"cssls",
					"tailwindcss",
					"lua_ls",
					"emmet_ls",
					"pyright",
					"clangd",
				}, -- Automatically install language servers
			})
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				python = { "pylint", "flake8" },
				cpp = { "cpplint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>l", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},

	{
		"neovim/nvim-lspconfig", -- LSP configuration
		config = function()
			local lspconfig = require("lspconfig")
			-- Python
			lspconfig.pyright.setup({})
			-- TypeScript/React
			lspconfig.tsserver.setup({})
			-- C++
			lspconfig.clangd.setup({})
			-- Tailwind CSS LSP
			lspconfig.tailwindcss.setup({})
		end,
	},

	-- Autocompletion setup
	{
		"hrsh7th/nvim-cmp", -- Completion plugin
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
			"hrsh7th/cmp-path", -- Path source for nvim-cmp
			"saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
			"L3MON4D3/LuaSnip", -- Snippet engine
			"onsails/lspkind-nvim", -- Icons for LSP completion
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" }, -- LSP source (Tailwind CSS will be included)
					{ name = "buffer" }, -- Buffer source
					{ name = "path" }, -- Path source
					{ name = "luasnip" }, -- Snippet source
					{ name = "supermaven" },
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				formatting = {
					format = require("lspkind").cmp_format({ with_text = true, maxwidth = 50 }),
				},
			})
		end,
	},
})
