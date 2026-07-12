--[[
-- File: treesitter.lua
-- Description: Treesitter parser config for modern syntax highlighting.
-- Design: Fast parse on buffer open, auto-installs core parsers.
--]]

return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on modern neovim
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        main = "nvim-treesitter",
        opts = {
            ensure_installed = {
                "c",
                "cpp",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "javascript",
                "html",
                "css",
                "rust",
                "markdown",
                "markdown_inline",
                "bash",
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
}
