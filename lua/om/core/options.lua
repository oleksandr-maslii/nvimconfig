vim.cmd("language en_US")
vim.cmd("let g:netrw_banner = 0")

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"

vim.opt.cursorline = true      -- Highlight the current line

vim.cmd [[
  highlight CursorLineNr guifg=#2596be gui=bold
]]

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"

vim.opt.backspace = { "start", "eol", "indent" }

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "250"

vim.opt.clipboard:append("unnamedplus")
vim.opt.hlsearch = true

vim.opt.mouse = "a"
vim.g.editorconfig = true


vim.api.nvim_create_user_command("LspWorkspaces", function()
  local folders = vim.lsp.buf.list_workspace_folders()
  if folders and #folders > 0 then
    print("LSP Workspace Folders:")
    for _, folder in ipairs(folders) do
      print("  • " .. folder)
    end
  else
    print("No LSP workspace folders found.")
  end
end, {})
