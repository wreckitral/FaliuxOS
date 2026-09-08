return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.opt.termguicolors = true
        require("nvim-tree").setup({
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 40,
                relativenumber = true,
                side = "right"
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
            git = {
                enable = true,
                ignore = false,
                timeout = 500,
            },
            on_attach = function(bufnr)
                local api = require("nvim-tree.api")

                -- Load all default mappings first
                api.config.mappings.default_on_attach(bufnr)

                local opts = function(desc)
                    return {
                        desc = "nvim-tree: " .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true,
                    }
                end

                -- Remap: create file with %
                vim.keymap.set("n", "%", api.fs.create, opts("Create File"))

                -- Remap: create directory with d
                vim.keymap.set("n", "d", api.fs.create, opts("Create Directory"))

                -- Remap: delete with R
                vim.keymap.set("n", "D", api.fs.remove, opts("Delete"))
            end,
        })
    end,
    keys = {
        { "<leader>pv", "<cmd>NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
        { "<leader>f", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Find File in Explorer" },
    }
}
