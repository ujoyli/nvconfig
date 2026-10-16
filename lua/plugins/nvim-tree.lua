--[[
-- File: nvim-tree.lua
-- Description: Nvim-tree file explorer plugin configuration.
-- Design: Provides sidebar file directory tree browsing and navigation.
--]]

return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
            { "<leader>ef", "<cmd>NvimTreeFindFile<cr>", desc = "Find current file in tree" },
        },
        opts = {
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
            update_focused_file = {
                enable = true,
                update_root = false,
            },
        },
    },
}
