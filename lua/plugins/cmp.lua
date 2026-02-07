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
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local cmp = require("cmp")

		require("luasnip.loaders.from_vscode").lazy_load()

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("%S") ~= nil
        end

		cmp.setup({
            completion = { autocomplete = { cmp.TriggerEvent.TextChanged, cmp.TriggerEvent.InsertEnter } },
			keyword_pattern = [[\k\+\.?]],
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = vim.schedule_wrap(function(fallback)
					if cmp.visible() and has_words_before() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					else
						fallback()
					end
				end),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete()
			}),
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end
			},
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
			}),
		})
	end
}
