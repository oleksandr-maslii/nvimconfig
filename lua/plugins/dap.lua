return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		"nicholasmata/nvim-dap-cs",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()
		require("nvim-dap-virtual-text").setup({
			enabled = true,
			enable_commands = true,
			all_frames = false,
		})

		require("dap-go").setup()
		require("dap-cs").setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end


		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open DAP REPL" })
		vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Toggle DAP UI" })

		vim.fn.sign_define("DapBreakpoint",
			{ text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
	end
}
