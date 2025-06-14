local M = {}

function M.build_dotnet_profiles(projectRoot)
	local profiles = {}
	local dotnet_utils = require("om.core.utils.dotnet")
	local launchProfiles = dotnet_utils.findLaunchSettings(projectRoot)

	local function parse_dotnet_profile(project_source_path, settings_json)
		local ok, data = pcall(vim.json.decode, table.concat(settings_json, "\n"))
		if not ok or not data.profiles then return {} end

		local tasks = {}
		for name, profile in pairs(data.profiles) do
			local env = profile.environmentVariables or {}
			if profile.applicationUrl then
				env.ASPNETCORE_URLS = profile.applicationUrl
			end

			local profile_full_name = "Run .NET (" .. name .. ") " .. project_source_path
			local csproj_path = "./" .. name .. "/" .. name .. ".csproj"

			table.insert(tasks, {
				name = profile_full_name,
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

	for path, settingsjson in pairs(launchProfiles) do
		local project_profiles = parse_dotnet_profile(path, settingsjson)
		for _, profile in ipairs(project_profiles) do
			table.insert(profiles, profile)
		end
	end

	return profiles
end

return M
