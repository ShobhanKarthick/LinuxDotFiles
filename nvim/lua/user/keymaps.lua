opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal Mode --
-- Window Navigation --

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- File Explorer --
--[[ keymap("n", "<leader>n", ":Lex 25<cr>", opts) ]]
keymap("n", "<leader>n", ":NvimTreeToggle<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate Buffers / Tabs
keymap("n", "<C-L>", ":tabnext<CR>", opts)
keymap("n", "<C-H>", ":tabprevious<CR>", opts)
keymap("n", "<C-`>", ":tabnext#<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
-- <C-J> ==> Simulates Ctrl + Shift + j ==> J is captital, so Shift + j
keymap("v", "<C-J>", ":m .+1<CR>==", opts)
keymap("v", "<C-K>", ":m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
-- <C-J> ==> Simulates Ctrl + Shift + j ==> J is captital, so Shift + j
keymap("x", "<C-J>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<C-K>", ":move '<-2<CR>gv-gv", opts)

-- Telescope Key binds
-- keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<C-F>", "<cmd>Telescope live_grep<cr>", opts)

-- Null LS
keymap("n", "<leader>j", ":lua vim.lsp.buf.formatting_sync()<CR>", opts)
