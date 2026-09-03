-- chunkname: @/tmp/or_script/lua_compile/logging/DpsLogger.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")
local logging = require(__PACKAGE__ .. "logging")
local openedLogFiles = {}

local function openFileLogger(filename, datePattern, logPattern)
	local filename = string.format(filename, os.date(datePattern))
	local fileHandler = openedLogFiles[filename]

	if fileHandler ~= nil then
		return fileHandler
	end

	fileHandler = io.open(filename, "a")

	if fileHandler then
		fileHandler:setvbuf("line")

		openedLogFiles[filename] = fileHandler

		if not logPattern then
			fileHandler:write(string.format("################## %s ##################\n", os.date()))
		end

		return fileHandler
	else
		return nil, string.format("file `%s' could not be opened for writing", filename)
	end
end

local function loggingFile(filename, datePattern, logPattern)
	assert(filename ~= nil, "`filename` CAN NOT be nil")

	return logging.new(function(self, level, message)
		local fileHandler, msg = openFileLogger(filename, datePattern, logPattern)

		if not fileHandler then
			return nil, msg
		end

		local s = logging.prepareLogMsg(logPattern, os.date(), level, message)

		fileHandler:write(s)

		return true
	end)
end

DpsLogger = DpsLogger or {
	_stdoutEnabled = true,
	_enabled = false,
	_loggers = {}
}
DpsLogger.LEVEL = {
	OFF = "OFF",
	DEBUG = logging.DEBUG,
	INFO = logging.INFO,
	WARN = logging.WARN,
	ERROR = logging.ERROR,
	FATAL = logging.FATAL
}
DpsLogger.PRIORITY = {
	OFF = 0,
	FATAL = 5,
	DEBUG = 1,
	WARN = 3,
	INFO = 2,
	ERROR = 4
}

function DpsLogger:init(path)
	assert(self._logRoot == nil, "Already initialized.")

	self._logRoot = path
end

function DpsLogger:enable()
	self._enabled = true
end

function DpsLogger:disable()
	self._enabled = false
end

function DpsLogger:stdoutDisable()
	self._stdoutEnabled = false
end

function DpsLogger:clear()
	self._enabled = false
	self._stdoutEnabled = true
	self._logRoot = nil
	self._loggers = {}
end

function DpsLogger:format(fmt, ...)
	local param = {
		...
	}
	local index = 1
	local start, ended = string.find(fmt, "{}")

	while start do
		local message = tostring(param[index])

		fmt = string.gsub(fmt, "{}", message, 1)
		index = index + 1
		start, ended = string.find(fmt, "{}")
	end

	return fmt
end

function DpsLogger:addLogger(category, level, outputs, logPattern)
	assert(self._logRoot ~= nil, "Need initialize the logRoot")

	if level == self.LEVEL.OFF then
		return
	end

	if not self.stdoutLogger then
		self.stdoutLogger = loggingFile(self:format("{}/stdout%s.log", self._logRoot), "%Y-%m-%d")

		self.stdoutLogger:setLevel(logging.DEBUG)
	end

	local appenders = {}

	for _, output in ipairs(outputs) do
		if output.filename then
			local appender = loggingFile(self:format("{}/{}%s.log", self._logRoot, output.filename), "%Y-%m-%d", logPattern)

			appender:setLevel(level)

			appenders[#appenders + 1] = {
				appender = appender,
				fmtfunc = output.fmtfunc
			}
			appenders[#appenders + 1] = {
				appender = self.stdoutLogger,
				fmtfunc = output.fmtfunc
			}
		else
			appenders[#appenders + 1] = {
				fmtfunc = output.fmtfunc
			}
		end

		level = level or logging.DEBUG
	end

	self._loggers[category] = {
		level = level,
		appenders = appenders
	}
end

function DpsLogger:isPriortyLower(level1, level2)
	return self.PRIORITY[level1] < self.PRIORITY[level2]
end

function DpsLogger:log(category, level, fmt, ...)
	if not self._enabled or not self._loggers[category] or self:isPriortyLower(level, self._loggers[category].level) then
		return
	end

	if self._loggers[category].level == self.LEVEL.OFF then
		return
	end

	local callerStack = debug.getinfo(3, "Sl")

	for _, appender in ipairs(self._loggers[category].appenders) do
		local content = appender.fmtfunc(string.match(callerStack.source, ".+/([^/]*%.%w+)$"), callerStack.currentline, fmt, ...)

		if appender.appender then
			appender.appender:log(level, content)
		end
	end
end

function DpsLogger:debug(category, fmt, ...)
	self:log(category, logging.DEBUG, fmt, ...)
end

function DpsLogger:info(category, fmt, ...)
	self:log(category, logging.INFO, fmt, ...)
end

function DpsLogger:warn(category, fmt, ...)
	self:log(category, logging.WARN, fmt, ...)
end

function DpsLogger:error(category, fmt, ...)
	self:log(category, logging.ERROR, fmt, ...)
end

function DpsLogger:fatal(category, fmt, ...)
	self:log(category, logging.FATAL, fmt, ...)
end
