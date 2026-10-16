--[[
-- File: rainbow-delimiters.lua
-- Description: Colorizes matching brackets/braces/parens by nesting level.
-- Design: Treesitter-based, so pairs inside strings/comments are ignored.
--]]

return {
    {
        "HiPhish/rainbow-delimiters.nvim",
        -- Load eagerly: the plugin attaches to buffers on the FileType event,
        -- which already fired by the time BufReadPost lazy-loading would kick in.
        lazy = false,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            -- Highlight groups used per nesting level (cycled in order)
            local palette = {
                RainbowDelimiterYellow = "#F1FA8C",
                RainbowDelimiterViolet = "#BD93F9",
                RainbowDelimiterCyan = "#8BE9FD",
                RainbowDelimiterGreen = "#50FA7B",
                RainbowDelimiterOrange = "#FFB86C",
                RainbowDelimiterBlue = "#6272A4",
                RainbowDelimiterRed = "#FF5555",
            }

            local function set_palette()
                for group, color in pairs(palette) do
                    vim.api.nvim_set_hl(0, group, { fg = color })
                end
            end

            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("custom_rainbow_palette", { clear = true }),
                callback = set_palette,
            })
            set_palette()

            require("rainbow-delimiters.setup").setup({
                strategy = {
                    [""] = "rainbow-delimiters.strategy.global",
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                highlight = {
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterRed",
                },
            })
        end,
    },
}
