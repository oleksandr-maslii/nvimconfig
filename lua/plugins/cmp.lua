return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "mingw32-make install_jsregexp CC=gcc",
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets"
	},
	config = function()
		local cmp = require("cmp")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			autocomplete = { "InsertEnter", "TextChangedI", "TextChangedP" },
			keyword_pattern = [[\k\+\.?]],
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab"] = cmp.mapping.select_prev_item(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete()
			}),
			snippet = {
				expand = function (args)
					require("luasnip").lsp_expand(args.body)
				end
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
			})
		})
	end
}
