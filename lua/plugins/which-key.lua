--[[
-- File: which-key.lua
-- Description: Which-key configuration for keybinding hints and quick menus.
-- Design: Right-bottom floating menu with helix preset (LazyVim style), and quick shortcuts.
--]]

return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        cmd = { "WhichKey" },
        opts = {
            preset = "helix", -- helix 预设位于屏幕右下角（类似 LazyVim 效果）
            win = {
                border = "rounded",
                col = -1,
                row = -1,
                padding = { 1, 2 },
            },
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader>b", group = "Buffer (缓冲区操作)" },
                    { "<leader>c", group = "Code (代码与重构)" },
                    { "<leader>e", group = "Explorer (文件树)" },
                    { "<leader>f", group = "Find (搜索/文件)" },
                    { "<leader>g", group = "Git (版本控制)" },
                    { "<leader>r", group = "Rename (重命名)" },
                    { "[", group = "Prev (上一项)" },
                    { "]", group = "Next (下一项)" },
                    { "g", group = "Goto (代码跳转)" },
                },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("telescope.builtin").keymaps()
                end,
                desc = "查询快捷键列表 (Search Keymaps)",
            },
            {
                "<leader><space>",
                function()
                    require("which-key").show({ keys = "<leader>" })
                end,
                desc = "展示功能菜单 (Which-key 菜单)",
            },
        },
    },
}
