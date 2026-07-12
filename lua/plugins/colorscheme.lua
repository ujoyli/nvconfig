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
            -- Enable the colorscheme
            vim.cmd([[colorscheme dracula]])
        end,
    },
}
