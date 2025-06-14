local M = {}
local registered_projects = {}

local function split(str, sep)
	local result = {}
	for part in string.gmatch(str, "([^" .. sep .. "]+)") do
		table.insert(result, part)
	end
	return result
end

local function load_golang_profile(projectRoot)
	local profile      = {}

	local parts        = split(projectRoot, '/')
	local mainPackage  = parts[#parts]
	profile["name"]    = "Run Go (" .. mainPackage .. ")"
	profile["builder"] = function()
		return {
			cmd = { "go" },
			args = { "run", "./cmd/" .. mainPackage },
			cwd = projectRoot,
			components = { "default" }
		}
	end

	return profile
end

local function load_dotnet_profile(projectRoot)
	local profiles = {}
	local fs_utils = require("om.core.utils.fs")
	local launchProfilePaths = fs_utils.findLaunchSettingsJsonPaths(projectRoot)

	local function parse_dotnet_profile(launch_file)
		local json = vim.fn.readfile(launch_file)
		if not json then return {} end
		local ok, data = pcall(vim.json.decode, table.concat(json, "\n"))
		if not ok or not data.profiles then return {} end

		local tasks = {}
		for name, profile in pairs(data.profiles) do
			local env = profile.environmentVariables or {}
			local csproj_path = "./" .. name .. "/" .. name .. ".csproj"
			table.insert(tasks, {
				name = "Run .NET (" .. name .. ")",
				builder = function()
					return {
						cmd = { "dotnet" },
						args = { "run", "--project", csproj_path },
						env = env,
						cwd = projectRoot,
						components = { "default" },
					}
				end,
			})
		end

		return tasks
	end

	for _, path in ipairs(launchProfilePaths) do
		local tasks = parse_dotnet_profile(path)
		for _, task in ipairs(tasks) do
			table.insert(profiles, task)
		end

	end

	return profiles
end


function M.on_lsp_attach(client)
	local workspaces = vim.lsp.buf.list_workspace_folders()
	if not workspaces then return end

	for _, root in ipairs(workspaces) do
		if not registered_projects[root] then
			registered_projects[root] = true

			local ok, overseer = pcall(require, "overseer")
			if ok then
				if client.name == "gopls" then
					overseer.register_template(load_golang_profile(root))
				elseif client.name == "roslyn" then
					--overseer.register_template()
					local profiles = load_dotnet_profile(root)
					for _, profile in ipairs(profiles) do
						overseer.register_template(profile)
					end
				end
			end
		end
	end
end

return M
