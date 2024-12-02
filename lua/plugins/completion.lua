return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
		"onsails/lspkind-nvim",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind") -- optional, to add icons to completion items

		-- Setup nvim-cmp with custom mappings and sources
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- Snippet expansion using LuaSnip
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.select_next_item(), -- Navigate completions with Tab
				["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Navigate completions with Shift+Tab
				["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion manually with Ctrl+Space
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion with Enter
				["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Scroll docs up
				["<C-d>"] = cmp.mapping.scroll_docs(4), -- Scroll docs down
			}),

			-- Completion sources
			sources = {
				{ name = "nvim_lsp" }, -- LSP for code completion
				{ name = "buffer" }, -- Buffer content for completion
				{ name = "path" }, -- Path completions
				{ name = "supermaven" }, -- Custom completion source, e.g., for Maven
			},

			-- Formatting the completion items
			formatting = {
				format = lspkind.cmp_format({
					with_text = true, -- Show text alongside icons
					menu = {
						nvim_lsp = "[LSP]",
						buffer = "[Buffer]",
						path = "[Path]",
						supermaven = "[Maven]",
					},
				}),
			},

			-- Documentation window for showing function signatures and descriptions
			window = {
				documentation = cmp.config.window.bordered(),
				completion = cmp.config.window.bordered({}),
			},

			-- Enable completion for LSP (hover and signature)
			completion = {
				completeopt = "menu,menuone,noselect",
			},
		})
	end,
}
