--[[
-- File: init.lua
-- Description: Entry point for Custom Neovim configuration.
-- Design: Bootstraps options, lazy.nvim plugin specs, keymaps, and autocommands.
--]]

-- Mock obsolete nvim-treesitter.configs to prevent Telescope crash in Neovim 0.11+
package.loaded["nvim-treesitter.configs"] = {
    is_enabled = function(...) return true end,
}

-- Load base configuration options
require("config.options")

-- Initialize lazy.nvim and load plugin specifications
require("config.lazy")

-- Load custom keybindings
require("config.keymaps")

-- Load autocommands
require("config.autocmds")
