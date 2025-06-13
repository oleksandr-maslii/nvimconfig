return {
	{
		"mason-org/mason.nvim",
		opts = {}
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = {
			ensure_installed = { "gopls" }
		},
	},
	{
		"neovim/nvim-lspconfig",
		config  = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.gopls.setup({
				capabilities = capabilities,
				settings = {
				  gopls = {
					analyses = {
					  unusedparams = true,
					  shadow = true,
					},
					staticcheck = true,
				  },
				},
			})
		end
	}
}
