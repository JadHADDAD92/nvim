return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"query",
		"javascript",
		"html",
		"python",
		"go",
		"yaml",
		"sql",
		"csv",
		"git_config",
		"git_rebase",
		"toml"
	  },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
 }
