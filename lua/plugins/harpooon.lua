return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon.setup()

		local function nmap(key, cmd, opts)
			vim.keymap.set("n", key, cmd, opts)
		end

		nmap("<leader>a", function()
			harpoon:list():append()
		end, { desc = "Add current file to Harpoon" })

		nmap("<C-g>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Show list of marks in Harpoon" })

		nmap("<C-h>", function()
			harpoon:list():select(1)
		end, { desc = "Select first mark in Harpoon" })
		nmap("<C-j>", function()
			harpoon:list():select(2)
		end, { desc = "Select second mark in Harpoon" })
		nmap("<C-k>", function()
			harpoon:list():select(3)
		end, { desc = "Select third mark in Harpoon" })
		nmap("<C-l>", function()
			harpoon:list():select(4)
		end, { desc = "Select fourth mark in Harpoon" })
	end,
}
