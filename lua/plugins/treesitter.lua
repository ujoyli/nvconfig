--[[
-- File: treesitter.lua
-- Description: Treesitter parser config for modern syntax highlighting.
-- Design: nvim-treesitter `main` branch API (setup/install + vim.treesitter.start).
--         The old `opts = { highlight = ..., indent = ... }` style is a no-op on this
--         branch, which is why highlighting/parsing was previously never enabled.
--]]

local ensure_installed = {
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
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        version = false, -- last release is way too old and doesn't work on modern neovim
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.setup({})

            -- Install any parser that is not available yet (async, no-op when complete)
            local installed = {}
            for _, lang in ipairs(ts.get_installed("parsers")) do
                installed[lang] = true
            end
            local missing = vim.tbl_filter(function(lang)
                return not installed[lang]
            end, ensure_installed)
            if #missing > 0 then
                ts.install(missing)
            end

            -- Enable treesitter highlighting (and indentation) per buffer.
            -- This is also what drives rainbow-delimiters, which needs a live parse tree.
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("custom_treesitter_start", { clear = true }),
                callback = function(event)
                    local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
                    if not lang or not vim.treesitter.language.add(lang) then
                        return
                    end
                    pcall(vim.treesitter.start, event.buf, lang)
                    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
