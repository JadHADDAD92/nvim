local M = {}

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_window(opts)
	opts = opts or {}

	local width = vim.o.columns
	local height = vim.o.lines

	local win_width = math.floor((opts.width or (width * 0.8)) + 0.5)
	local win_height = math.floor((opts.height or (height * 0.6)) + 0.5)

	local row = math.floor((height - win_height) / 2)
	local col = math.floor((width - win_width) / 2)

	local buf = nil

	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	end

	local win_opts = {
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	}

	local win = vim.api.nvim_open_win(buf, true, win_opts)

	return { buf = buf, win = win }
end

vim.api.nvim_create_user_command("Floaterm", function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
			vim.cmd.startinsert()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end, {})

function M.setup(opts)
	opts = opts or {}

	state.floating = create_floating_window({
		width = opts.width,
		height = opts.height,
	})
end

vim.api.nvim_set_keymap("n", "<leader>tt", ":Floaterm<CR>", { noremap = true, silent = true })

return {
	name = "floaterm", -- Optional name for Lazy.nvim
	dir = ".",
	setup = M.setup, -- Lazy.nvim will call `setup` on load
}
