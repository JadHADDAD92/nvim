return {
	"AckslD/nvim-trevJ.lua",
	config = function()
		require("trevj").setup() -- optional call for configurating non-default filetypes etc
	end,

	vim.keymap.set("n", "<leader>j", function()
		require("trevj").format_at_cursor()
	end, { desc = "Break lines at cursor" }),
}
