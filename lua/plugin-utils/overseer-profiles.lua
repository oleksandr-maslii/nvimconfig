local M = {}
local registered_projects = {}

local dotnet_profile_builder = require("plugin-utils.dotnet-overseer-profile-builder")
local strings_utils = require("om.core.utils.strings")

local function load_golang_profile(projectRoot)
	local profile      = {}

	local parts        = strings_utils.split(projectRoot, '/')
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
					local profiles = dotnet_profile_builder.build_dotnet_profiles(root)
					for _, profile in ipairs(profiles) do
						overseer.register_template(profile)
					end
				end
			end
		end
	end
end

return M
