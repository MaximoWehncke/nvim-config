local function supermaven_status()
	local ok, api = pcall(require, "supermaven-nvim.api")
	if not ok then
		return ""
	end
	if api.is_running() then
		return "󰓞"
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

local function filename()
    return {
        function()
            local name = vim.fn.expand("%:t")
            if name == "" then return "[No Name]" end
            local modified = vim.bo.modified and " ●" or ""
            local readonly = vim.bo.readonly and " " or ""
            return name .. modified .. readonly
        end,
        color = { fg = "#C0CAF5", gui = "italic" },
        padding = { left = 1, right = 1 },
        separator = { left = "", right = "" },
    }
end

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
				lualine_b = { fileicon(), filename()},
				lualine_c = { "branch" },
				lualine_d = {
					{
						require("recorder").recordingStatus,
						color = { fg = "#ff9e64" },
					},
					"%S",
				},
				lualine_x = {
					{
						supermaven_status, -- function is the first element
						color = function()
							local ok, api = pcall(require, "supermaven-nvim.api")
							if ok and api.is_running() then
								return { fg = "#28FF2C" }
							else
								return { fg = "#ea6962" }
							end
						end,
					},
				},
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
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					fileicon(),filename(),
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = {},
		})
		vim.opt.laststatus = 0
	end,
}
