-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Tools\\logging.lua

local type, table, string, assert, _tostring = type, table, string, assert, tostring
local logging = {}
local DEBUG = "DEBUG"
local INFO = "INFO"
local WARN = "WARN"
local ERROR = "ERROR"
local FATAL = "FATAL"
local SEND = "SEND"
local RECV = "RECV"
local LEVEL = {
	[DEBUG] = 1,
	[INFO] = 2,
	[WARN] = 3,
	[ERROR] = 4,
	[FATAL] = 5,
	[SEND] = 6,
	[RECV] = 7
}

function logging.new(append)
	if type(append) ~= "function" then
		return nil, "Appender must be a function."
	end

	local logger = {}

	logger.level = DEBUG
	logger.append = append

	function logger:setLevel(level)
		assert(LEVEL[level], string.format("undefined level `%s'", tostring(level)))

		self.level = level
	end

	function logger:log(level, message)
		assert(LEVEL[level], string.format("undefined level `%s'", tostring(level)))

		if LEVEL[level] < LEVEL[self.level] then
			return
		end

		if type(message) ~= "string" then
			message = tostring(message)
		end

		return logger:append(level, message)
	end

	function logger.debug(logger, message)
		return logger:log(DEBUG, message)
	end

	function logger.info(logger, message)
		return logger:log(INFO, message)
	end

	function logger.warn(logger, message)
		return logger:log(WARN, message)
	end

	function logger.error(logger, message)
		return logger:log(ERROR, message)
	end

	function logger.fatal(logger, message)
		return logger:log(FATAL, message)
	end

	function logger.send(logger, message)
		return logger:log(SEND, message)
	end

	function logger.recv(logger, message)
		return logger:log(RECV, message)
	end

	return logger
end

function logging.prepareLogMsg(pattern, dt, level, message)
	local logMsg = pattern or "%level %message\n"

	message = string.gsub(message, "%%", "%%%%")
	logMsg = string.gsub(logMsg, "%%level", level)
	logMsg = string.gsub(logMsg, "%%message", message)

	return logMsg
end

function logging.tostring(value)
	local str = ""

	if type(value) ~= "table" then
		if type(value) == "string" then
			str = string.format("%q", value)
		else
			str = _tostring(value)
		end
	else
		local auxTable = {}

		table.foreach(value, function(i, v)
			if tonumber(i) ~= i then
				table.insert(auxTable, i)
			else
				table.insert(auxTable, tostring(i))
			end
		end)
		table.sort(auxTable)

		str = str .. "{"

		local separator = ""
		local entry = ""

		table.foreachi(auxTable, function(i, fieldName)
			if tonumber(fieldName) and tonumber(fieldName) > 0 then
				entry = tostring(value[tonumber(fieldName)])
			else
				entry = fieldName .. " = " .. tostring(value[fieldName])
			end

			str = str .. separator .. entry
			separator = ", "
		end)

		str = str .. "}"
	end

	return str
end

return logging
