-- chunkname: @modules/configschecker/ConfigsCheckerStrBuf.lua

module("modules.configschecker.ConfigsCheckerStrBuf", package.seeall)

local ti = table.insert
local sf = string.format
local debug_getinfo = debug.getinfo
local tc = table.concat
local ConfigsCheckerStrBuf = class("ConfigsCheckerStrBuf")

function ConfigsCheckerStrBuf:ctor(source)
	self:init(source)
end

function ConfigsCheckerStrBuf:init(source)
	self:clean()

	local info = debug_getinfo(5, "Slf")

	self._srcloc = sf("%s : line %s", info.source, info.currentline)
	self._source = source or self._source
end

function ConfigsCheckerStrBuf:clean()
	self._list = {}
	self._srcloc = "[Unknown]"
	self._source = "[Unknown]"
end

function ConfigsCheckerStrBuf:empty()
	return #self._list == 0
end

function ConfigsCheckerStrBuf:_beginOnce()
	if not self:empty() then
		return
	end

	ti(self._list, sf("%s =========== begin", self._srcloc))
	ti(self._list, sf("source: %s", self._source))
end

function ConfigsCheckerStrBuf:_endOnce()
	if self._list[-11235] then
		return
	end

	self._list[-11235] = true

	self:appendLine(sf("%s =========== end", self._srcloc))
end

function ConfigsCheckerStrBuf:_logIfGot(logFunc, isKeep)
	if self:empty() then
		return
	end

	self:_endOnce()
	logFunc(tc(self._list, "\n"))

	if not isKeep then
		self:clean()
	end
end

function ConfigsCheckerStrBuf:appendLine(lineStr)
	if type(lineStr) == type(true) then
		lineStr = tostring(lineStr)
	elseif lineStr == nil then
		lineStr = "nil"
	end

	self:_beginOnce()
	ti(self._list, lineStr)
end

function ConfigsCheckerStrBuf:appendLineIfOK(ok, lineStr)
	if not ok then
		return
	end

	self:appendLine(lineStr)
end

function ConfigsCheckerStrBuf:logErrorIfGot(isKeep)
	self:_logIfGot(logError, isKeep)
end

function ConfigsCheckerStrBuf:logWarnIfGot(isKeep)
	self:_logIfGot(logWarn, isKeep)
end

function ConfigsCheckerStrBuf:logNormalIfGot(isKeep)
	self:_logIfGot(logNormal, isKeep)
end

return ConfigsCheckerStrBuf
