return {
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.install")
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"sql",
					"css",
					"scss",
					"go",
					"c_sharp",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"typescript",
					"dockerfile",
				},
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true
				}
			})
		end,
	},
}
