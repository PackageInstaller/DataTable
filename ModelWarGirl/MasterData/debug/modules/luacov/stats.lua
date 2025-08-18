-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\luacov\\stats.lua

local stats = {}

function stats.load(statsfile)
	local data = {}
	local fd = io.open(statsfile, "r")

	if not fd then
		return nil
	end

	while true do
		local max = fd:read("*n")

		if not max then
			break
		end

		if fd:read(1) ~= ":" then
			break
		end

		local filename = fd:read("*l")

		if not filename then
			break
		end

		data[filename] = {
			max_hits = 0,
			max = max
		}

		for i = 1, max do
			local hits = fd:read("*n")

			if not hits then
				break
			end

			if fd:read(1) ~= " " then
				break
			end

			if hits > 0 then
				data[filename][i] = hits
				data[filename].max_hits = math.max(data[filename].max_hits, hits)
			end
		end
	end

	fd:close()

	return data
end

function stats.save(statsfile, data)
	local fd = assert(io.open(statsfile, "w"))
	local filenames = {}

	for filename in pairs(data) do
		table.insert(filenames, filename)
	end

	table.sort(filenames)

	for _, filename in ipairs(filenames) do
		local filedata = data[filename]

		fd:write(filedata.max, ":", filename, "\n")

		for i = 1, filedata.max do
			fd:write(tostring(filedata[i] or 0), " ")
		end

		fd:write("\n")
	end

	fd:close()
end

return stats
