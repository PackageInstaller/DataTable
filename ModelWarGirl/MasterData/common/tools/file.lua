-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Tools\\file.lua

local logging = require("Common/Tools/logging")

function logging.file(filename, datePattern, logPattern)
	if type(filename) ~= "string" then
		filename = "lualogging.log"
	end

	filename = string.format(filename, os.date(datePattern))

	local f = io.open(filename, "a")

	if not f then
		return nil, string.format("file `%s' could not be opened for writing", filename)
	end

	f:setvbuf("line")

	local logger = logging.new(function(self, level, message)
		local s = logging.prepareLogMsg(logPattern, os.date(), level, message)

		f:write(s)
		f:flush()

		return true
	end)

	function logger:close()
		f:close()

		return true
	end

	function logger:close()
		f:close()

		return true
	end

	return logger
end

return logging.file
