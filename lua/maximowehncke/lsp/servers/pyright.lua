local function set_python_path(command)
	local path = command.args
	local clients = vim.lsp.get_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = "pyright",
	})
	for _, client in ipairs(clients) do
		local settings = client.settings or client.config.settings or {}
		settings = vim.tbl_deep_extend("force", settings, { python = { pythonPath = path } })
		if client.settings then
			client.settings = settings
		else
			client.config.settings = settings
		end
		client:notify("workspace/didChangeConfiguration", { settings = nil })
	end
end

local function use_project_venv(config, root_dir)
	config.settings = config.settings or {}
	config.settings.python = config.settings.python or {}
	if not root_dir then
		return false
	end

	for _, name in ipairs({ ".venv", "venv" }) do
		local env = root_dir .. "/" .. name
		local python = vim.fn.has("win32") == 1 and (env .. "/Scripts/python.exe") or (env .. "/bin/python")
		if vim.fn.executable(python) == 1 then
			config.settings.python.venvPath = root_dir
			config.settings.python.venv = name
			config.settings.python.pythonPath = python
			return true
		end
	end
	return false
end

-- Hooks like on_new_config/before_init/on_init are not forwarded to the client
-- by this setup, so point pyright at the project's venv on attach instead.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("PyrightProjectVenv", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client or client.name ~= "pyright" or client._venv_applied then
			return
		end
		client._venv_applied = true
		if use_project_venv(client, client.root_dir) then
			client:notify("workspace/didChangeConfiguration", { settings = client.settings })
		end
	end,
})

---@type vim.lsp.Config
return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyrightconfig.json",
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},
	settings = {
		pyright = {
			disableTaggedHints = true,
		},
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
			---@diagnostic disable-next-line: param-type-mismatch
			client.request("workspace/executeCommand", {
				command = "pyright.organizeimports",
				arguments = { vim.uri_from_bufnr(bufnr) },
			}, nil, bufnr)
		end, { desc = "Organize Imports" })

		vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
			desc = "Set Pyright Python interpreter",
			nargs = 1,
			complete = "file",
		})
	end,
}
