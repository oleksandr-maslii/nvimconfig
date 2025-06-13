return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
		local install = require("nvim-treesitter.install")
		require("nvim-treesitter.configs").setup({
			highlight = {
			  enable = true,
			  additional_vim_regex_highlighting = false,
			},
		})
    end,
  },
}
