--[[
-- File: telescope.lua
-- Description: Telescope fuzzy finder configuration.
-- Design: Binds quick global searches to Leader key sequences.
--]]

return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
            { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Find by Grep" },
            { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find Buffers" },
            { "<leader>fs", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Find Symbols" },
            { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Find Help Tags" },
        },
        config = function()
            -- Inject compatibility shim for nvim-treesitter.parsers.ft_to_lang under Neovim 0.11+
            local ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
            if ok and ts_parsers and not ts_parsers.ft_to_lang then
                ts_parsers.ft_to_lang = function(ft)
                    local ts_lang = vim.treesitter.language
                    return (ts_lang and ts_lang.get_lang(ft)) or ft
                end
            end

            require("telescope").setup({})
        end,
    },
}
