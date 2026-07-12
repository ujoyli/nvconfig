--[[
-- File: lualine.lua
-- Description: Beautiful statusline plugin with Powerline icons and Dracula theme integration.
-- Design: Configures custom statusline sections including git branch, relative filepath, and encoding.
--]]

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- Required for file type icons
        event = "VeryLazy", -- Load when needed to save startup time
        config = function()
            require("lualine").setup({
                options = {
                    theme = "dracula", -- Matches our custom Dracula colorscheme automatically
                    component_separators = { left = "", right = "" }, -- Thin separators
                    section_separators = { left = "", right = "" },   -- Thick powerline arrows
                    disabled_filetypes = {
                        statusline = { "lazy", "mason" },
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true, -- Set statusline to occupy full width across multiple splits
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = {
                        {
                            "filename",
                            path = 1, -- 0: Just filename, 1: Relative path, 2: Absolute path
                        },
                    },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },
}
