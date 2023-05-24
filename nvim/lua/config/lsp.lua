----------------------------------------------------------------------------------------
-- Mason setup
----------------------------------------------------------------------------------------

require('mason').setup({
  ui = {
    border = 'rounded'
  }
})

----------------------------------------------------------------------------------------
-- LSP Setup
----------------------------------------------------------------------------------------

local lsp = require('lsp-zero')

lsp.preset({"recommended"})

lsp.ensure_installed({
  'tsserver',
  'eslint',
})


lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
  local opts = {buffer = bufnr}

  vim.keymap.set({'n', 'x'}, '<leader>j', function()
    vim.lsp.buf.format({async = false, timeout_ms = 10000})
  end, opts)
end)

lsp.setup()

----------------------------------------------------------------------------------------
-- cmp Setup [You need to setup `cmp` after lsp-zero]
----------------------------------------------------------------------------------------

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    -- changing the order of fields so the icon is the first
    fields = {'menu', 'abbr', 'kind'},

    -- here is where the change happens
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
        nvim_lua = 'Π',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = true}),

    -- Tab complete
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ["<Up>"] = cmp.mapping.select_prev_item(cmp_select_opts),
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select_opts),
    ["<Down>"] = cmp.mapping.select_next_item(cmp_select_opts),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select_opts),
  }
})

