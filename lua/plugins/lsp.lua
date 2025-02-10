return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local max_length = 50 -- Adjust as needed
						if #diagnostic.message > max_length then
							return nil -- Prevent virtual text from showing
						end
						return diagnostic.message
					end,
				},
				float = {
					source = "always",
					border = "rounded",
				},
			})

			-- Show floating diagnostic on CursorHold
			vim.api.nvim_create_autocmd("CursorHold", {
				pattern = "*",
				callback = function()
					local opts = {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always",
						prefix = " ",
					}
					if not vim.diagnostic.open_float(nil, opts) then
						print("No diagnostics available")
					end
				end,
			})

			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				local keymap = vim.keymap.set

				-- Enable hover for function signatures
				vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
					border = "rounded",
				})

				-- Key mappings for LSP
				keymap("n", "gd", vim.lsp.buf.definition, opts)
				keymap("n", "gD", vim.lsp.buf.declaration, opts)
				keymap("n", "gi", vim.lsp.buf.implementation, opts)
				keymap("n", "gr", vim.lsp.buf.references, opts)
				keymap("n", "K", vim.lsp.buf.hover, opts)
			end

			lspconfig.pyright.setup({ on_attach = on_attach })
			lspconfig.tsserver.setup({ on_attach = on_attach })
			lspconfig.clangd.setup({ on_attach = on_attach })
			lspconfig.tailwindcss.setup({ on_attach = on_attach })
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
					"lua_ls",
					"emmet_ls",
				},
			})
		end,
	},
}
