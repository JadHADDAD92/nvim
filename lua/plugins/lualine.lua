return {
	"nvim-lualine/lualine.nvim",
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			show_filename_only = false,
			path = 1,
			component_separators = "|",
			section_separators = "",
		},
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(str)
						return str:sub(1, 1)
					end,
				},
			},
			lualine_b = {
				{ "branch" },
				{ "diff" },
				{
					"diagnostics",
					symbols = { error = "E", warn = "W", info = "I", hint = "H" },
					update_in_insert = true,
				},
			},
		},
	},
}
