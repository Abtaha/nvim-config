return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.pyright.setup({
                on_attach = function(client, bufnr)
                    -- Enable hover for function signatures
                    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                    border = "rounded",  -- Rounded border for hover docs
                    })
                end,
            })
			lspconfig.tsserver.setup({})
			lspconfig.clangd.setup({})
			lspconfig.tailwindcss.setup({})
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright",
					"tsserver",
					"clangd",
					"tailwindcss",
					"html",
					"cssls",
					"tailwindcss",
					"lua_ls",
					"emmet_ls",
				},
			})
		end,
	},
}
