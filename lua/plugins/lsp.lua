return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")

			mason.setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				}
			})

			mason_lspconfig.setup({
				automatic_enable = true,
				ensure_installed = { "gopls", "lua_ls" },
				automatic_installation = true,
			})
		end
	},
}
