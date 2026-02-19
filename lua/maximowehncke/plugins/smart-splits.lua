return {
	"mrjones2014/smart-splits.nvim",
	config = function()
		require("smart-splits").setup({

			default_amount = 12,

			-- Configuration
			resize_mode = {
				silent = true,
				hooks = {
					on_enter = function()
						vim.notify("Entering resize mode", vim.log.levels.INFO)
					end,
					on_leave = function()
						vim.notify("Exiting resize mode", vim.log.levels.INFO)
					end,
				},
			},
		})

		-- Resize windows with r prefix (like your tmux setup)
		vim.keymap.set("n", "rh", require("smart-splits").resize_left, { desc = "Resize left" })
		vim.keymap.set("n", "rj", require("smart-splits").resize_down, { desc = "Resize down" })
		vim.keymap.set("n", "rk", require("smart-splits").resize_up, { desc = "Resize up" })
		vim.keymap.set("n", "rl", require("smart-splits").resize_right, { desc = "Resize right" })

		vim.keymap.set("n", "<leader>wh", require("smart-splits").swap_buf_left, { desc = "Swap with left" })
		vim.keymap.set("n", "<leader>wj", require("smart-splits").swap_buf_down, { desc = "Swap with bottom" })
		vim.keymap.set("n", "<leader>wk", require("smart-splits").swap_buf_up, { desc = "Swap with top" })
		vim.keymap.set("n", "<leader>wl", require("smart-splits").swap_buf_right, { desc = "Swap with right" })
	end,
}
