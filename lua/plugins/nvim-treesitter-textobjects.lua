return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					look = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]M"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]m"] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[M"] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[m"] = "@class.outer",
					},
				},
			},
		})
	end,
}
