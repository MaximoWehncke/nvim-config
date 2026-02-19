return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			notify_on_error = false,
			-- Format only TypeScript and TSX files on save
			format_on_save = function(bufnr)
				-- Only enable format_on_save for TypeScript and TSX files
				local filetype = vim.bo[bufnr].filetype
				if filetype == "typescript" or filetype == "typescriptreact" then
					return {
						timeout_ms = 2000,
						lsp_format = "fallback",
					}
				end
				-- Return nil to disable formatting for other filetypes
				return nil
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang-format" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				java = { "google-java-format" },
			},
			formatters = {
				prettier = {
					args = {
						"--write",
						"--config",
						"frontend/prettier.config.js",
						"--ignore-path",
						"frontend/.prettierignore",
						"$FILENAME",
					},
				},
			},
		},
	},
}
