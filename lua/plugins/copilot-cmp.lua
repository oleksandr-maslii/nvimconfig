return {
	"zbirenbaum/copilot-cmp",
	dependencies = {
		"zbirenbaum/copilot.lua",
		"onsails/lspkind.nvim",
	},
	config = function()
		local lspkind = require("lspkind")
		lspkind.init({
			symbol_map = {
				Copilot = "",
			},
		})

		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
		require("copilot_cmp").setup()
	end
}
