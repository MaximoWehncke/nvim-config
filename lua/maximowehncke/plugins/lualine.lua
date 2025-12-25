return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"chrisgrieser/nvim-recorder",
	},
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = "auto",
				disabled_filetypes = { "packer", "NvimTree" },
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				globalstatus = false,
				padding = 4,
				always_divide_middle = false,
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			winbar = {
				lualine_a = { "mode" },
				lualine_b = { "filename" },
				lualine_c = { "branch" },
				lualine_d = {
					{
						require("recorder").recordingStatus,
						color = { fg = "#ff9e64" },
					},
					"%S",
				},
				lualine_x = { "diff" },
				lualine_y = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
				},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {
					{
						"filetype",
						color = { bg = "#282828" }, -- same as normal background
						separator = { left = "", right = "" },
					},
				},
				lualine_b = {
					{
						"filename",
						color = { bg = "#282828", fg = "#ffffff", gui = "bold" },
						separator = { left = "", right = "" },
						padding = 2,
					},
				},
				lualine_c = { "location" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = {},
		})
		vim.opt.laststatus = 0
	end,
}
