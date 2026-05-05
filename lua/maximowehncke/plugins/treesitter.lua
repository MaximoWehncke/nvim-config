return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
			{
					"andymass/vim-matchup",
					init = function()
							vim.g.matchup_matchparen_offscreen = { method = "popup" }
					end,
					config = function()
							vim.api.nvim_create_autocmd("FileType", {
									pattern = { "html" },
									callback = function()
											vim.b.matchup_matchparen_enabled = 0
									end,
							})
					end,
			},
		},
		config = function()
			vim.g.skip_ts_context_commentstring_module = true
			require("ts_context_commentstring").setup({ enable_autocmd = false })
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
				per_filetype = {
					["html"] = { enable_close = false },
				},
			})
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = {
					"go", "c", "lua", "javascript", "typescript", "tsx",
					"html", "css", "java", "bash", "json", "markdown",
					"markdown_inline", "svelte", "graphql", "dockerfile",
					"gitignore", "query", "vim", "vimdoc", "yaml", "python",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				matchup = {
					enable = true,
					disable = { "html" },
				},
			})
		end,
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
        vim.keymap.set({ "x", "o" }, "af", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "if", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "ac", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "ic", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "aa", function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "ia", function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "ab", function() require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "ib", function() require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "al", function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "il", function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "ai", function() require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "ii", function() require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects") end)

        -- move
        vim.keymap.set({ "n", "x", "o" }, "]f", function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]c", function() require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]a", function() require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]F", function() require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]C", function() require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]A", function() require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.inner", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[f", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[c", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[a", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[F", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[C", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[A", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.inner", "textobjects") end)

        -- swap
        vim.keymap.set("n", "<leader>a", function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end)
        vim.keymap.set("n", "<leader>A", function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end)
    end,
	},
	{
		"wansmer/treesj",
		keys = {
			{
				"<leader>nm",
				function() require("treesj").toggle() end,
				desc = "Toggle split/join",
			},
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = { use_default_keymaps = false },
	},
}
