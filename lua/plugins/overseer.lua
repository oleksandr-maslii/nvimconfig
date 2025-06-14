return {
	"stevearc/overseer.nvim",
	opts = {

	},
	config = function ()
		local overseer = require("overseer")
		overseer.setup()

		vim.keymap.set("n", "<leader>ovr", "<cmd>OverseerRun<CR>")
		vim.keymap.set("n", "<leader>ovt", "<cmd>OverseerToggle<CR>")
	end
}
