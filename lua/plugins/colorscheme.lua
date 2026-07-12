--[[
-- File: colorscheme.lua
-- Description: Color scheme configuration.
-- Design: Uses tokyonight for modern, beautiful dark/light themes.
--]]

return {
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000, -- Load this colorscheme first before other plugins
        config = function()
            local dracula = require("dracula")
            dracula.setup({
                colors = {
                    bg = "#1E1F35",      -- Dracula Remastered background (deep ocean navy)
                    green = "#21E4B3",   -- Turquoise for functions
                    orange = "#FF9E95",  -- Coral for parameters/macros
                    purple = "#c299ff",  -- Bright lavender for constants/readonly variables
                },
            })
            -- Enable the colorscheme
            vim.cmd([[colorscheme dracula]])
        end,
    },
}
