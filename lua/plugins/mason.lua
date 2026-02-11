return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		config = function()
			local mason = require("mason")
			mason.setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
				ensure_installed = {
                    "gopls",
                    "lua_ls",
                    "html",
                    "cssls",
                    "vue-language-server",
                    "typescript-language-server",
                    "rust-analyzer",
                    "clangd",
                },
			})
		end
	},
}
