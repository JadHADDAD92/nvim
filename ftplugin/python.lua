local ts_utils = require("nvim-treesitter.ts_utils")

local function highlight_async(bufnr, row, col_start, col_end)
	vim.cmd("highlight AsyncInsert ctermfg=White ctermbg=Green guifg=#FFFFFF guibg=#857310")
	local ns_id = vim.api.nvim_create_namespace("async_highlight")
	local extmark_id = vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, col_start, {
		hl_group = "AsyncInsert",
		end_col = col_end,
		priority = 1000,
	})
	vim.defer_fn(function()
		vim.api.nvim_buf_del_extmark(bufnr, ns_id, extmark_id)
	end, 600)
end

-- Function to make the enclosing function async and highlight the change
local function make_function_async()
	local bufnr = vim.api.nvim_get_current_buf()
	local node = ts_utils.get_node_at_cursor()
	if not node then
		return
	end

	while node do
		if node:type() == "function_definition" then
			local start_row, start_col = node:range()
			local line = vim.fn.getline(start_row + 1)
			if not line:match("^%s*async%s+def") then
				local new_line = line:gsub("def", "async def", 1)
				vim.fn.setline(start_row + 1, new_line)
				highlight_async(bufnr, start_row, line:find("def") - 1, line:find("def") + 4)
			end
			break
		end
		node = node:parent()
	end
end

local function has_await_keyword(node)
	if node == nil then
		return false
	end

	if node:type() == "await" then
		return true
	end

	for _, child in ipairs(ts_utils.get_named_children(node)) do
		if has_await_keyword(child) then
			return true
		end
	end

	return false
end

local function get_function_node(node)
	while node do
		if node:type() == "function_definition" then
			return node
		end
		node = node:parent()
	end

	return nil
end

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	pattern = "*.py",
	desc = "Add async keyword to function definition if await keyword is found",
	group = vim.api.nvim_create_augroup("async_added", { clear = true }),
	callback = function()
		local node = ts_utils.get_node_at_cursor()
		local function_node = get_function_node(node)
		if has_await_keyword(function_node) then
			make_function_async()
		end
	end,
})
