vim.g.mapleader = " "

-- delete buffer
vim.keymap.set("n", "<A-c>", "<cmd>bdelete<CR>")

-- in v mode J for moving block of code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- in n mode make code under go inline
vim.keymap.set("n", "J", "mzJ`z")

-- in n mode jump down and up
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- in n mode jump to words that is just searched
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- start vim with me plugin
vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- pasting without having to copy again
vim.keymap.set("x", "<leader>p", [["_dP]])

-- delete without copy to buffer
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- next greatest remap ever : asbjornHaland
-- in v mode copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- This is going to get me cancelled
-- in insert mode pressing i m
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- in normal mode go to packer file
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/ralph/lazy/init.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Start preview (document mode)
vim.keymap.set("n", "<leader>tp", function()
  vim.cmd("TypstPreview")
end, { desc = "Typst: Start Preview" })

-- TYPSY RELATED --
-- Start preview (slide mode)
vim.keymap.set("n", "<leader>ts", function()
  vim.cmd("TypstPreview slide")
end, { desc = "Typst: Start Slide Preview" })

-- Stop preview
vim.keymap.set("n", "<leader>tq", function()
  vim.cmd("TypstPreviewStop")
end, { desc = "Typst: Stop Preview" })

-- Toggle preview
vim.keymap.set("n", "<leader>to", function()
  vim.cmd("TypstPreviewToggle")
end, { desc = "Typst: Toggle Preview" })

-- Enable follow cursor
vim.keymap.set("n", "<leader>tc", function()
  require("typst-preview").set_follow_cursor(true)
end, { desc = "Typst: Enable Follow Cursor" })

-- Disable follow cursor
vim.keymap.set("n", "<leader>tn", function()
  require("typst-preview").set_follow_cursor(false)
end, { desc = "Typst: Disable Follow Cursor" })

-- Toggle follow cursor
vim.keymap.set("n", "<leader>tC", function()
  local preview = require("typst-preview")
  preview.set_follow_cursor(not preview.get_follow_cursor())
end, { desc = "Typst: Toggle Follow Cursor" })

-- Sync preview to cursor (without enabling auto-follow)
vim.keymap.set("n", "<leader>tx", function()
  require("typst-preview").sync_with_cursor()
end, { desc = "Typst: Sync Preview to Cursor" })

-- end
