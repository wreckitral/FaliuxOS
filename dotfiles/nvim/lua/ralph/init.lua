require("ralph.set")
require("ralph.remap")
require("ralph.lazy_init")

vim.cmd[[colorscheme tokyonight]]
vim.o.conceallevel = 1

-- create autocmd group
local augroup = vim.api.nvim_create_augroup
local RalphGroup = augroup('Ralph', {})

-- create autocmd group
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

-- reload plenary
function R(name)
    require("plenary.reload").reload_module(name)
end

-- auto highlight text after yoink
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- delete blank line at the end of a line
autocmd({"BufWritePre"}, {
    group = RalphGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
    group = RalphGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

-- file browser clean look
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- dim unused window
vim.cmd([[
    " Active window with transparent background
    hi ActiveWindow guibg=NONE

    " Inactive window with a dimmed background
    hi InactiveWindow guibg=#282c34

    " Apply the highlight groups to active and inactive windows
    set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
]])

