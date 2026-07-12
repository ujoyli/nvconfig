--[[
-- File: lazy.lua
-- Description: Bootstrap and configure lazy.nvim plugin manager.
-- Design: Clones lazy.nvim if missing, and loads specifications from lua/plugins directory.
--]]

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Configure and initialize lazy.nvim
require("lazy").setup({
    spec = {
        -- Import plugins from lua/plugins directory
        { import = "plugins" },
    },
    defaults = {
        -- Do not lazy-load all plugins by default, load them explicitly
        lazy = false,
        version = false, -- always use the latest git commit
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = false }, -- check for updates regularly
    performance = {
        rtp = {
            -- Disable unused built-in plugins for faster startup
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
