return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.config").setup({
            ensure_installed = {
                "vimdoc", "javascript", "typescript", "c", "lua", "rust",
                "jsdoc", "bash", "go", "markdown", "markdown_inline"
            },
            sync_install = false,
            auto_install = true,
        })

        -- enable highlighting manually since new API removed it
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local ok = pcall(vim.treesitter.start)
                if not ok then
                    vim.treesitter.stop()
                end
            end,
        })
    end
}
