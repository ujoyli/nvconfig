--[[
-- File: lsp.lua
-- Description: Language Server Protocol (LSP) and Autocomplete configuration.
-- Design: Integrates Mason for server installs, nvim-lspconfig, and nvim-cmp.
--]]

return {
    -- LSP Configuration & Plugins
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- Autocompletion engine and sources
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            -- Set up Mason
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "clangd", "rust_analyzer" }, -- Install Lua, C++, and Rust language servers by default
            })

            -- Bind LSP keymaps on server attach (Neovim 0.11+ best practice)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local nmap = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
                    end

                    nmap("gd", vim.lsp.buf.definition, "Goto Definition")
                    nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
                    nmap("gI", vim.lsp.buf.implementation, "Goto Implementation")
                    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                    nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
                    nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
                    nmap("<leader>d", vim.diagnostic.open_float, "Show Line Diagnostics")
                end,
            })

            -- Setup nvim-cmp capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            -- Configure and enable servers using Neovim 0.11+ native APIs to avoid deprecation warnings
            require("lspconfig")
            
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
            })
            vim.lsp.enable("lua_ls")
            
            vim.lsp.config("clangd", {
                capabilities = capabilities,
            })
            vim.lsp.enable("clangd")
            
            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities,
            })
            vim.lsp.enable("rust_analyzer")

            -- Setup autocompletion config
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
            })
        end,
    },
}
