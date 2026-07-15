require("om.core")
require("config.lazy")

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

vim.o.completeopt = "menu,menuone,noselect"

