-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

vim.keymap.set("n", "<leader>e", function()
	-- If a diagnostic float we opened is still around, jump into it
	local win = vim.b.diag_float_win
	if win and vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_set_current_win(win)
		return
	end

	-- Otherwise open a new one (focusable so we can select/yank)
	local _, w = vim.diagnostic.open_float(nil, {
		scope = "line",
		source = true,
		border = "rounded",
		focusable = true,
	})

	-- Remember the window so a second press can focus it
	if w and vim.api.nvim_win_is_valid(w) then
		vim.b.diag_float_win = w

		-- Clear the handle when the float closes
		vim.api.nvim_create_autocmd("WinClosed", {
			once = true,
			callback = function(args)
				if tonumber(args.match) == w then
					vim.b.diag_float_win = nil
				end
			end,
		})
	end
end, { desc = "Show/focus diagnostic [E]rror float" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Center Screen on Vertical Motions
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Shortcut to open NetRW
vim.keymap.set("n", "<leader>pd", vim.cmd.Ex)

-- Shortcut to toggle Inlay Hints
vim.keymap.set("n", "<leader>tih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end, { desc = "Toggle Inlay Hints" })
