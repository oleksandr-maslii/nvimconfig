return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} }
	},
	config = function ()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function (ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				vim.keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP Type definitions"
				vim.keymap.set("n", "<leader>gti", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>vca", function () vim.lsp.buf.code_action() end, opts)

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Show method documentation"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>lrs", ":LspRestart<CR>", opts)

				vim.keymap.set("i", "<C-h>", function ()
					vim.lsp.buf.signature_help()
				end, opts)
			end
		})

		local signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
            [vim.diagnostic.severity.INFO]  = " ",
        }

		vim.diagnostic.config({
			signs = {
				text = signs
			},
			virtual_text = true,
			underline = true,
			update_in_insert = false
		})

		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local overseer_profiles = require("plugin-utils.overseer-profiles")

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace"
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true
						}
					}
				}
			}
		})

		lspconfig.gopls.setup({
			on_attach = function (client)
				overseer_profiles.on_lsp_attach(client)
			end,
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
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

		vim.lsp.config("roslyn", {
			on_attach = function(client)
				overseer_profiles.on_lsp_attach(client)
			end,
			settings = {
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = true,
					dotnet_enable_tests_code_lens = true,
				},
				["csharp|completion"] = {
					dotnet_provide_regex_completions = true,
					dotnet_show_completion_items_from_unimported_namespaces = true,
					dotnet_show_name_completion_suggestions = true,
				},
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = true,
				}
			}
		})
	end
}
