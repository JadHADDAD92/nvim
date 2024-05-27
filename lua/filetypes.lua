vim.filetype.add({
	extension = {
		env = "dotenv",
	},
	filename = {
		[".env"] = "sh",
	},
	pattern = {
		["%.env%.[%w_.-]+"] = "sh",
	},
})
