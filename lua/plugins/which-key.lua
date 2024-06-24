return {
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").register({
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			["<leader>h"] = { name = "[H]unk", _ = "which_key_ignore" },
			["<leader>n"] = {
				name = "Neotest",
				a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
				f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
				F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
				l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
				L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
				n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
				N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
				o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
				S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
				s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
			},
		})
	end,
}
