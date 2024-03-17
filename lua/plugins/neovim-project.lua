return {
	"coffebar/neovim-project",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
		{ "Shatur/neovim-session-manager" },
	},
	lazy = false,
	priority = 100,

	init = function()
		-- enable saving the state of plugins in the session
		vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
	end,

	config = function()
		require("neovim-project").setup({
			projects = {
				"~/workspace/personal/*",
				"~/workspace/work/*",
			},
		})

		vim.keymap.set("n", "<C-p>h", function()
			vim.cmd(":Telescope neovim-project history")
		end, { desc = "NeoVim Projects History" })

		vim.keymap.set("n", "<C-p>d", function()
			vim.cmd(":Telescope neovim-project discover")
		end, { desc = "NeoVim Projects Discover" })
	end,
}
