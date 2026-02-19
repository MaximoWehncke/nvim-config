return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"axkirillov/telescope-changed-files", -- Add this dependency
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		-- [[ Configure Telescope ]]
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-_>"] = "which_key", -- <C-_> is what terminals send for Ctrl+/
						["<C-h>"] = "which_key", -- Alternative: Ctrl+h for help
					},
					n = {
						["?"] = "which_key", -- Show help in normal mode
					},
				},
				layout_strategy = "vertical",
				layout_config = {
					horizontal = {
						preview_width = 0.9,
						results_width = 0.9,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				-- Configure changed_files extension
				changed_files = {
					-- Show changes compared to what? Options: HEAD, index, unstaged
					show_diff_base = "HEAD",
				},
			},
		})

		-- Enable Telescope extensions
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "changed_files")

		-- Keymaps
		local builtin = require("telescope.builtin")
		local keymap = vim.keymap

		keymap.set("n", "<leader>fg", builtin.git_status, { desc = "[F]ind [G]it changed files" })

		-- Standard telescope keymaps
		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		vim.keymap.set("n", "<leader>fb", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
