vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- empty setup using defaults

require("jad.remap")
require("jad.lazy")
require("jad.lsp")
print("hello from jad/")
require("nvim-tree").setup()

