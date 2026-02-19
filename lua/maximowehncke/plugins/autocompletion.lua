return {
	{ -- Autocompletion
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			-- Snippet Engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {},
				opts = {},
			},
			"folke/lazydev.nvim",
		},
		opts = {
			keymap = {
				preset = "default",
				-- Custom keymaps to avoid Tab conflicts with tabout
				["<Tab>"] = {}, -- Disable Tab for blink (let tabout handle it)
				["<S-Tab>"] = {}, -- Disable Shift-Tab for blink (let copilot/tabout handle it)

				-- navigate snippets
				["<C-j>"] = { "snippet_forward", "fallback" },
				["<C-k>"] = { "snippet_backward", "fallback" },

				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<C-y>"] = { "select_and_accept" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},
			sources = {
				default = { "lsp", "path", "snippets", "lazydev" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},
			snippets = { preset = "luasnip" },
			fuzzy = { implementation = "lua" },
			signature = { enabled = true },
		},
	},
	-- {
	-- 	"github/copilot.vim",
	-- 	priority = 999,
	-- 	event = "InsertEnter",
	-- 	init = function()
	-- 		vim.g.copilot_no_tab_map = true
	-- 		vim.g.copilot_assume_mapped = true
	-- 	end,
	-- 	config = function()
	-- 		local keymap = vim.keymap
	-- 		vim.g.copilot_no_tab_map = true
	--
	-- 		vim.keymap.set("i", "<S-Tab>", function()
	-- 			return vim.fn["copilot#Accept"]("")
	-- 		end, {
	-- 			expr = true,
	-- 			replace_keycodes = false,
	-- 			desc = "Accept Copilot suggestion",
	-- 		})
	-- 		keymap.set(
	-- 			"n",
	-- 			"<leader>cd",
	-- 			"<cmd>Copilot disable<CR><cmd>echo 'Copilot suggestion disabled'<CR>",
	-- 			{ desc = "Disable Copilot suggestions", silent = true }
	-- 		)
	-- 		keymap.set(
	-- 			"n",
	-- 			"<leader>ce",
	-- 			"<cmd>Copilot enable<CR><cmd>echo 'Copilot suggestion enabled'<CR>",
	-- 			{ desc = "Enable Copilot suggestions", silent = true }
	-- 		)
	-- 	end,
	-- },
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<S-Tab>",
					clear_suggestion = "<C-]>",
					accept_word = "<C-j>",
				},
				ignore_filetypes = { cpp = true }, -- or { "cpp", }
				color = {
					suggestion_color = "#767676",
					cterm = 244,
				},
				log_level = "info", -- set to "off" to disable logging completely
				disable_inline_completion = false, -- disables inline completion for use with cmp
				disable_keymaps = false, -- disables built in keymaps for more manual control
				condition = function()
					return false
				end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.

        vim.keymap.set("n", "<leader>cst", "<cmd>SupermavenToggle<CR><cmd>echo 'SuperMaven toggled'<CR>", {desc = "Toggle supermacen suggestions on/off"})
			})
		end,
	},
}
