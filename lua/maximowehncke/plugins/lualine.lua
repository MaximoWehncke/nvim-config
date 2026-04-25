local function supermaven_status()
	local ok, api = pcall(require, "supermaven-nvim.api")
	if not ok then
		return ""
	end
	if api.is_running() then
		return "󰠖"
	else
		return ""
	end
end

local function fileicon()
	return {
		function()
			local filename = vim.fn.expand("%:t")
			local ext = vim.fn.expand("%:e")
			local ok, devicons = pcall(require, "nvim-web-devicons")
			return ok and devicons.get_icon(filename, ext, { default = true }) or ""
		end,
		color = function()
			local filename = vim.fn.expand("%:t")
			local ext = vim.fn.expand("%:e")
			local ok, devicons = pcall(require, "nvim-web-devicons")
			if ok then
				local _, hl = devicons.get_icon(filename, ext, { default = true })
				local fg = hl and vim.fn.synIDattr(vim.fn.hlID(hl), "fg#") or "#C0CAF5"
				return { fg = fg }
			end
			return { fg = "#C0CAF5" }
		end,
		padding = { left = 1, right = 0 },
		separator = { left = "", right = "" },
	}
end

return {
	{
		"vimpostor/vim-tpipeline",
		init = function()
			vim.g.tpipeline_split = 0
			vim.g.tpipeline_clearstl = 1
			vim.g.tpipeline_autoempty = 1 -- auto empty when pane is not focused
		end,
	},
	{
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
					globalstatus = true,
					padding = 4,
					always_divide_middle = false,
				},
				winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {},
					lualine_c = {
						"branch",
						fileicon(),
						{
							function()
								return " "
							end,
							padding = { left = 0, right = 0 },
						},
						{
							"filename",
							padding = { left = 0, right = 1 },
						},
						{
							lazy_status.updates,
							cond = lazy_status.has_updates,
							color = { fg = "#ff9e64" },
							padding = { left = 2, right = 1 },
						},
						{
							supermaven_status,
							color = function()
								local ok, api = pcall(require, "supermaven-nvim.api")
								if ok and api.is_running() then
									return { fg = "#FF7A65" }
								else
									return { fg = "#ea6962" }
								end
							end,
							padding = { left = 0, right = 1 },
						},
					},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						fileicon(),
						"filename",
					},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				extensions = {},
			})
			-- vim.opt.laststatus = 0
		end,
	},
}
