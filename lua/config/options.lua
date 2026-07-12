--[[
-- File: options.lua
-- Description: Standard Neovim options for formatting, search, UI, and general editor behavior.
-- Design: Kept clean and generic. Loads standard settings applicable to macOS and Linux.
--]]

-- Define leader keys early before any plugin loads
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Compatibility shims for Telescope/plugins in Neovim 0.10+
local ts_lang = vim.treesitter.language
if ts_lang and not ts_lang.ft_to_lang then
    ts_lang.ft_to_lang = function(ft)
        return ts_lang.get_lang(ft) or ft
    end
end
if not vim.treesitter.ft_to_lang then
    vim.treesitter.ft_to_lang = function(ft)
        return (ts_lang and ts_lang.get_lang(ft)) or ft
    end
end

local opt = vim.opt

-- General settings
opt.mouse = "a"                         -- Enable mouse support
opt.clipboard = "unnamedplus"           -- Sync with system clipboard
opt.completeopt = { "menu", "menuone", "noselect" } -- CMP autocomplete options

-- UI Configuration
opt.number = true                       -- Show line numbers
opt.relativenumber = true               -- Show relative line numbers
opt.signcolumn = "yes"                  -- Keep signcolumn open
opt.cursorline = true                   -- Highlight current line
opt.termguicolors = true                -- Enable 24-bit RGB colors
opt.showmode = false                    -- Don't show mode (already in statusline)
opt.splitright = true                   -- Vertical split to the right
opt.splitbelow = true                   -- Horizontal split below
opt.scrolloff = 8                       -- Keep at least 8 lines visible above/below cursor
opt.sidescrolloff = 8                   -- Keep at least 8 columns visible left/right of cursor

-- Tabs & Indentation
opt.tabstop = 4                         -- 1 tab = 4 spaces
opt.shiftwidth = 4                      -- 1 indent = 4 spaces
opt.expandtab = true                    -- Expand tab to spaces
opt.autoindent = true                   -- Copy indent from current line when starting new line
opt.smartindent = true                  -- Smart autoindenting for new lines

-- Search
opt.ignorecase = true                   -- Ignore case in search patterns
opt.smartcase = true                    -- Override ignorecase if search contains capitals
opt.hlsearch = true                     -- Highlight all matches on previous search pattern
opt.incsearch = true                    -- Show search matches while typing

-- Backups & History
opt.swapfile = false                    -- Do not create swap files
opt.backup = false                      -- Do not create backup files
opt.undofile = true                     -- Enable persistent undo
opt.updatetime = 250                    -- Decrease update time for faster feedback

-- File encoding
opt.fileencoding = "utf-8"              -- The encoding written to a file
