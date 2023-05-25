local toggleterm = require("toggleterm")

local function on_create(term)
  -- Get the root directory where the Git directory is present
  local root_folder = vim.fn.finddir(".git/..", ";")
  toggleterm.exec("cd " .. root_folder)
end

toggleterm.setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 14
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true,      -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  autochdir = false,        -- when neovim changes it current directory the terminal will change it's own when next it's opened
  shade_terminals = true,   -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
  shading_factor = -20,     -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
  start_in_insert = true,
  insert_mappings = true,   -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
  direction = 'horizontal',
  close_on_exit = true,     -- close the terminal window when the process exits
  shell = vim.o.shell,
  auto_scroll = true,       -- automatically scroll to the bottom on terminal output
  float_opts = {
    border = "curved",
    winblend = 2,
    zindex = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
  winbar = {
    enabled = true,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
}

function _G.set_terminal_keymaps()
  local opts = { buffer = 0, noremap = true }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = vim.fn.getcwd(),
  direction = "float",
  hidden = true,
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<esc>", "", { noremap = true, silent = true })
  end,
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

local extraTerm = Terminal:new({
  cmd = "python",
  dir = vim.fn.getcwd(),
  hidden = true,
  direction = "float",
})

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

function _EXTRA_TERM()
  extraTerm:toggle()
end
