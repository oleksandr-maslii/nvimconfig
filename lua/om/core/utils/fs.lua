local M = {}

function M.openFile(filePath)
	local luv = vim.loop

	local fd = luv.fs_open(filePath, "r", 438)
	if not fd then return nil end

	local stat = luv.fs_stat(filePath)
	if not stat then return nil end

	local data = luv.fs_read(fd, stat.size)

	return data
end

return M
