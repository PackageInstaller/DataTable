-- chunkname: @/tmp/or_script/lua_compile/logging/logging.lua

local type, table, string, _tostring, tonumber = type, table, string, tostring, tonumber
local select = select
local error = error
local format = string.format
local pairs = pairs
local ipairs = ipairs
local logging = {
	_VERSION = "LuaLogging 1.3.0",
	WARN = "WARN",
	_DESCRIPTION = "A simple API to use logging features in Lua",
	FATAL = "FATAL",
	DEBUG = "DEBUG",
	_COPYRIGHT = "Copyright (C) 2004-2013 Kepler Project",
	INFO = "INFO",
	ERROR = "ERROR"
}
local LEVEL = {
	"DEBUG",
	"INFO",
	"WARN",
	"ERROR",
	"FATAL"
}
local MAX_LEVELS = #LEVEL

for i = 1, MAX_LEVELS do
	LEVEL[LEVEL[i]] = i
end

local function LOG_MSG(self, level, fmt, ...)
	local f_type = type(fmt)

	if f_type == "string" then
		if select("#", ...) > 0 then
			return self:append(level, format(fmt, ...))
		else
			return self:append(level, fmt)
		end
	elseif f_type == "function" then
		return self:append(level, fmt(...))
	end

	return self:append(level, logging.tostring(fmt))
end

local LEVEL_FUNCS = {}

for i = 1, MAX_LEVELS do
	local level = LEVEL[i]

	LEVEL_FUNCS[i] = function(self, ...)
		return LOG_MSG(self, level, ...)
	end
end

local function disable_level()
	return
end

local function assert(exp, ...)
	if exp then
		return exp, ...
	end

	error(format(...), 2)
end

function logging.new(append)
	if type(append) ~= "function" then
		return nil, "Appender must be a function."
	end

	local logger = {}

	logger.append = append

	function logger:setLevel(level)
		local order = LEVEL[level]

		assert(order, "undefined level `%s'", _tostring(level))

		self.level = level
		self.level_order = order

		for i = 1, MAX_LEVELS do
			local name = LEVEL[i]:lower()

			self[name] = order <= i and LEVEL_FUNCS[i] or disable_level
		end
	end

	function logger:log(level, ...)
		local order = LEVEL[level]

		assert(order, "undefined level `%s'", _tostring(level))

		if order < self.level_order then
			return
		end

		return LOG_MSG(self, level, ...)
	end

	logger:setLevel(logging.DEBUG)

	return logger
end

function logging.prepareLogMsg(pattern, dt, level, message)
	local logMsg = pattern or "%date %level %message\n"

	message = string.gsub(message, "%%", "%%%%")
	logMsg = string.gsub(logMsg, "%%date", dt)
	logMsg = string.gsub(logMsg, "%%level", level)
	logMsg = string.gsub(logMsg, "%%message", message)

	return logMsg
end

local function tostring(value)
	local str = ""

	if type(value) ~= "table" then
		str = type(value) == "string" and string.format("%q", value) or _tostring(value)
	else
		local auxTable = {}

		for key in pairs(value) do
			if tonumber(key) ~= key then
				table.insert(auxTable, key)
			else
				table.insert(auxTable, tostring(key))
			end
		end

		table.sort(auxTable)

		str = str .. "{"

		local separator = ""

		for _, fieldName in ipairs(auxTable) do
			str = str .. separator .. (tonumber(fieldName) and tonumber(fieldName) > 0 and tostring(value[tonumber(fieldName)]) or fieldName .. " = " .. tostring(value[fieldName]))
			separator = ", "
		end

		str = str .. "}"
	end

	return str
end

logging.tostring = tostring

if _VERSION ~= "Lua 5.2" then
	_G.logging = logging
end

return logging
