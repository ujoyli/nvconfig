--[[
-- File: autocmds.lua
-- Description: Autocommands (events) for Neovim.
-- Design: Configures custom behaviors triggered on Neovim events (e.g. highlighting text on yank).
--]]

local function create_augroup(name)
    return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Highlight on yank (copy)
vim.api.nvim_create_autocmd("TextYankPost", {
    group = create_augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 150,
        })
    end,
})

-- Resize splits if window is resized
vim.api.nvim_create_autocmd("VimResized", {
    group = create_augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd(current_tab .. "tabnext")
    end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = create_augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "query",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-summary",
        "neotest-output-panel",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})
