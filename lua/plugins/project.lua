return {
	"ahmedkhalf/project.nvim",
	config = function ()
		require("project_nvim").setup({
			patterns = { ".git", ".sln", ".csproj", "package.json", "go.work", "go.mod" }
		})

		require("telescope").load_extension("projects")

		vim.keymap.set("n", "<leader>rp", "<cmd>Telescope projects<CR>")
	end
}
