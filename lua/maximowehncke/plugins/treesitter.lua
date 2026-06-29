return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		commit = "c82bf96",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = {
					"go",
					"c",
					"lua",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"java",
					"bash",
					"json",
					"markdown",
					"markdown_inline",
					"svelte",
					"graphql",
					"dockerfile",
					"gitignore",
					"query",
					"vim",
					"vimdoc",
					"yaml",
					"python",
				},
			})

			-- highlight/indent/folding must be enabled manually on `main`
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo.foldmethod = "expr"
				end,
			})

			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
	{
		"hiphish/rainbow-delimiters.nvim", -- Modern rainbow parentheses + matching
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("rainbow-delimiters.setup").setup({
				strategy = require("rainbow-delimiters.strategy.global"),
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
			per_filetype = {
				["html"] = {
					enable_close = false,
					enable_rename = false,
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			-- select
			vim.keymap.set({ "x", "o" }, "af", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "if", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ac", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ic", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "aa", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ia", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ab", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ib", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "al", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "il", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ai", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ii", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
			end)

			-- move
			vim.keymap.set({ "n", "x", "o" }, "]f", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]c", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]a", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]F", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]C", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]A", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.inner", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[f", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[c", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[a", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[F", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[C", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[A", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.inner", "textobjects")
			end)

			-- swap
			vim.keymap.set("n", "<leader>a", function()
				require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
			end)
			vim.keymap.set("n", "<leader>A", function()
				require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
			end)
		end,
	},
}
