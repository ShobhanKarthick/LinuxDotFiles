require("tokyonight").setup{
  style = "night",
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
  },
}

vim.cmd[[colorscheme tokyonight]]
