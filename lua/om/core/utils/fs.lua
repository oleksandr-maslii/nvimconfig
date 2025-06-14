local M = {}

function M.findLaunchSettingsJsonPaths(rootDir)
	local luv = vim.loop
	local result = {}

	local function scan(path)
		local dir = luv.fs_scandir(path)
		if not dir then return end

		while true do
			local name, type = luv.fs_scandir_next(dir)
			if not name then break end

			local subPath = path .. "/" .. name
			if type == "file" and name == "launchSettings.json" then
				table.insert(result, subPath)
			elseif type == "directory" then
				scan(subPath)
			end
		end
	end

	scan(rootDir)

	return result
end

function M.readFile(path)
	local luv = vim.loop

	local fd = luv.fs_open(path, "r", 438)
	if not fd then
		return nil
	end

	local stat = luv.fs_stat(path)
	if not stat then
		return nil
	end

	local data = luv.fs_read(fd, stat.size, 0)
	luv.fs_close(fd)

	return data
end

return M
