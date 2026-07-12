--[[
-- File: colorscheme.lua
-- Description: Color scheme configuration.
-- Design: Uses tokyonight for modern, beautiful dark/light themes.
--]]

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000, -- Load this colorscheme first before other plugins
        config = function()
            require("tokyonight").setup({
                style = "moon", -- storm, night, moon, day
                transparent = false,
                terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                },
            })
            -- Enable the colorscheme
            vim.cmd([[colorscheme tokyonight-moon]])
        end,
    },
}
