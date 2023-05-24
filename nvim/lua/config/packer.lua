-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer.Nvim
  use 'wbthomason/packer.nvim'

  -- Telescope: Fuzzy finding, Live grep and much more...
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Rose-Pine: A fantastic colorscheme with many variants!
  use({ 'rose-pine/neovim', as = 'rose-pine' })

  -- Nvim-treesitter: Provides the best language-based highlighting & parsing
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

  -- Undo tree: Enables unlimited undos and a sort of VCS
  use('mbbill/undotree')

  -- LSP Config & Autocompletion
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },       -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },       -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },           -- Required
      { 'hrsh7th/cmp-nvim-lsp' },       -- Required
      { 'L3MON4D3/LuaSnip' },           -- Required
    }
  }

  -- Nvim-tree: A file explorer
  use({
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },     -- optional
  })

  -- ToggleTerm: Can spawn mutipple configurable terminal windows inside Nvim
  use { "akinsho/toggleterm.nvim", tag = '*' }

  -- Autopairs: Closes brackets and quotes automatically
  use({ "windwp/nvim-autopairs" })

  -- MarkdownPreview: A super cool markdown viewer - has similar UI like Github
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  })

  -- Commenting
  use("numToStr/Comment.nvim") 
	use("JoosepAlviste/nvim-ts-context-commentstring")

  -- flutter-tools.nvim: Flutter Specific Plugin
  --[[ use { ]]
  --[[   'akinsho/flutter-tools.nvim', ]]
  --[[   requires = { ]]
  --[[       'nvim-lua/plenary.nvim', ]]
  --[[       'stevearc/dressing.nvim', -- optional for vim.ui.select ]]
  --[[   }, ]]
--[[ } ]]

end)
