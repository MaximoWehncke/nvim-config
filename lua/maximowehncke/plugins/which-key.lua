return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		preset = "modern", -- or "classic" / "helix"
		win = {
			-- Position on the right side
			no_overlap = true,
			width = { min = 20, max = 50 }, -- Adjust width as needed
			height = { min = 4, max = 25 },
			row = 0,                     -- Top of screen (change to math.huge for bottom)
			col = math.huge,             -- Right side (0 for left)
			border = "rounded",          -- Optional: add a border
			padding = { 1, 2 },
			title = true,
			title_pos = "center",
			zindex = 1000,
			wo = {
				-- winblend = 10, -- Optional transparency
			},
		},
		layout = {
			width = { min = 20, max = 50 },
			spacing = 3,
		},
	},
}
