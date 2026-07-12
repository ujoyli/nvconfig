--[[
-- File: telescope.lua
-- Description: Telescope fuzzy finder configuration.
-- Design: Binds quick global searches to Leader key sequences.
--]]

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
            { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Find by Grep" },
            { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find Buffers" },
            { "<leader>fs", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Find Symbols" },
            { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Find Help Tags" },
        },
        config = function()
            require("telescope").setup({})
        end,
    },
}
