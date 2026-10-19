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

            -- A buffer can end up with an empty 'filetype' when it is read before
            -- $VIMRUNTIME/filetype.lua registers its detection autocommands, or
            -- when it is loaded without a FileType event. Without a filetype
            -- neither treesitter nor the legacy syntax file is enabled, which is
            -- why such a buffer only gets highlighting after a manual reload.
            -- Recover the filetype here so both get enabled on first open.
            local function ensure_filetype(buf)
                local ft = vim.bo[buf].filetype
                if ft ~= "" then
                    return ft
                end
                if vim.bo[buf].buftype ~= "" then
                    return nil
                end
                local name = vim.api.nvim_buf_get_name(buf)
                if name == "" then
                    return nil
                end
                local match, on_detect = vim.filetype.match({ buf = buf, filename = name })
                if match then
                    if on_detect then
                        on_detect(buf)
                    end
                    -- Setting 'filetype' fires FileType (ftplugin/syntax) and
                    -- therefore also the treesitter autocommand below.
                    vim.bo[buf].filetype = match
                end
                return match
            end

            local function start(buf)
                if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
                    return
                end
                if vim.treesitter.highlighter.active[buf] then
                    return
                end

                local ft = vim.bo[buf].filetype
                if ft == "" then
                    ft = ensure_filetype(buf)
                    -- Setting 'filetype' above may already have started the
                    -- highlighter through the FileType autocommand.
                    if vim.treesitter.highlighter.active[buf] then
                        return
                    end
                end
                if not ft or ft == "" then
                    return
                end

                local lang = vim.treesitter.language.get_lang(ft)
                if not lang or not vim.treesitter.language.add(lang) then
                    return
                end
                if not pcall(vim.treesitter.start, buf, lang) then
                    return
                end
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end

            local group = vim.api.nvim_create_augroup("custom_treesitter_start", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                callback = function(event)
                    start(event.buf)
                end,
            })
            -- BufReadPost/BufNewFile also cover buffers read while filetype
            -- detection was not available yet; BufWinEnter/BufEnter cover
            -- buffers displayed without ever emitting FileType.
            vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWinEnter", "BufEnter" }, {
                group = group,
                callback = function(event)
                    start(event.buf)
                end,
            })

            -- Buffers that were already open before this config ran.
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) then
                    start(buf)
                end
            end
        end,
    },
}
