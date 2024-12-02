local keymap = vim.keymap.set


-- File explorer
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


-- Telescope
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

-- Formatter
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Format file or range (in visual mode)" })