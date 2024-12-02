return {
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
            },
            extensions = { "nvim-tree" }, -- Add any extra extensions, such as nvim-tree
        })
    end,
}