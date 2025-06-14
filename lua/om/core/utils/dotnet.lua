local M = {}

function M.findLaunchSettings(rootDir)
	local luv = vim.loop
	local result = {}

	local function scan(path)
		local dir = luv.fs_scandir(path)
		if not dir then return end

		while true do
			local name, type = luv.fs_scandir_next(dir)
			if not name then break end

			if type == "directory" and name == "Properties" then
				local launch_settings = vim.fn.readfile(path .. "/" .. "Properties/launchSettings.json")
				if launch_settings then
					result[path] = launch_settings
				end
			elseif type == "directory" then
				scan(path .. "/" .. name)
			end
		end
	end

	scan(rootDir)

	return result
end

return M
