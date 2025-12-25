return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	lazy = false,
	priority = 1000,
	opts = {
		options = {
			mode = "tabs", -- Show buffers, not tabs
			separator_style = "thin",

			numbers = "ordinal",

			-- Offset for file explorers
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
					separator = true,
				},
			},

			-- Clean look
			show_buffer_close_icons = false,
			show_close_icon = false,
			always_show_bufferline = true,
		},
	},
	keys = {
		-- Navigate buffers
		{ "<S-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },

		-- Go to buffer by number
		{ "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
		{ "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
		{ "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
		{ "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
		{ "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" },
		{ "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" },
		{ "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" },
		{ "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" },
		{ "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" },
		{ "<leader>0", "<cmd>BufferLineGoToBuffer -1<CR>", desc = "Go to last buffer" },

		-- Close buffers
		{ "<leader>bc", "<cmd>bdelete<CR>", desc = "Close buffer" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
		{ "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", desc = "Close buffers to left" },
		{ "<leader>bl", "<cmd>BufferLineCloseRight<CR>", desc = "Close buffers to right" },

		-- Move buffers
		{ "<leader>b<", "<cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },
		{ "<leader>b>", "<cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
	},
}
