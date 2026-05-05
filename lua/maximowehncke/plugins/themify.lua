return {
	{
		"lmantw/themify.nvim",
		lazy = false,
		priority = 999,
		dependencies = {
			-- Add all colorscheme plugins as dependencies
			"folke/tokyonight.nvim",
			"sho-87/kanagawa-paper.nvim",
			"catppuccin/nvim",
			"ellisonleao/gruvbox.nvim",
		},
		config = function()
			require("themify").setup({
				-- Your list of colorschemes.
				{
					"folke/tokyonight.nvim",
					priority = 1000,
					config = function()
						vim.cmd([[colorscheme tokyonight]])
					end,
				},
				{ "sho-87/kanagawa-paper.nvim" },
				{
					"catppuccin/nvim",
					name = "catppuccin",
					priority = 1000,
				},
				{
					"ellisonleao/gruvbox.nvim",
					priority = 1000,
					config = function()
						require("gruvbox").setup()
					end,
				},
				{
					"rose-pine/neovim",
					name = "rose-pine",
					config = function()
						vim.cmd("colorscheme rose-pine")
					end,
				},
				{
					"zitrocode/carvion.nvim",
					priority = 1000,
					config = function()
						vim.cmd("colorscheme carvion")
					end,
				},
				{
					"tiagovla/tokyodark.nvim",
					name = "tokyodark",
					priority = 1000,
					config = function()
						vim.cmd("colorscheme tokyodark")
					end,
				},
				{
					"AlexvZyl/nordic.nvim",
					name = "nordic",
					priority = 1000,
					config = function()
						vim.cmd("colorscheme nordic")
					end,
				},
				{
					"sainnhe/sonokai",
					name = "sonokai",
					priority = 1000,
					config = function()
						vim.cmd("colorscheme sonokai")
					end,
				},
				{
					"navarasu/onedark.nvim",
					priority = 1000, -- make sure to load this before all the other start plugins
					config = function()
						require("onedark").setup({
							style = "darker",
						})
						require("onedark").load()
					end,
				},
				"default",
			})
		end,
	},
}
