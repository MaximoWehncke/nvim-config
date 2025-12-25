return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- Notifier config (from earlier)
		notifier = {
			enabled = true,
			top_down = false,
			timeout = 3000,
		},

		-- Scroll config (FIXED - removed extra table wrapper)
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 10, total = 200 },
				easing = "linear",
			},
			-- Faster animation when repeating scroll after delay
			animate_repeat = {
				delay = 100, -- delay in ms before using the repeat animation
				duration = { step = 5, total = 50 },
				easing = "linear",
			},
			-- What buffers to animate
			filter = function(buf)
				return vim.g.snacks_scroll ~= false
					and vim.b[buf].snacks_scroll ~= false
					and vim.bo[buf].buftype ~= "terminal"
			end,
		},
	},
}
