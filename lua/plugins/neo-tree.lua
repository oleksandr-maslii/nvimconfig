return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- optional icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
		selector = true,
		source_selector = {
			winbar = true,
			statusline = false,
		},
		sources = {
			"filesystem",
			"git_status",
		},
		window = {
			position = "right",
			width = 40,
		},
		filesystem = {
			follow_current_file = {
			  enabled = true,
			}
		}
    })
	vim.keymap.set("n", "<leader>o", ":Neotree reveal<CR>")
  end
}
