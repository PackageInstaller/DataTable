-- chunkname: @modules/logic/gm/view/Checker_Base.lua

module("modules.logic.gm.view.Checker_Base", package.seeall)

local Checker_Base = class("Checker_Base")

Checker_Base.Color = {
	Blue = "#0000FF",
	Green = "#00FF00",
	Red = "#FF0000",
	Yellow = "#FFFF00",
	White = "#FFFFFF"
}

function Checker_Base:makeColorStr(str, hexColor)
	return gohelper.getRichColorText(tostring(str), hexColor or "#FFFFFF")
end

function Checker_Base:ctor()
	self:clearAll()
end

function Checker_Base:clearAll()
	self._strBuilder = {}
	self._indentCount = 0
	self._stackIndent = {}
	self._stackMarkLineIndex = {}
end

function Checker_Base:lineCount()
	return #self._strBuilder
end

function Checker_Base:addIndent()
	self._indentCount = self._indentCount + 1
end

function Checker_Base:subIndent()
	self._indentCount = self._indentCount - 1
end

function Checker_Base:pushIndent()
	table.insert(self._stackIndent, self._indentCount)

	self._indentCount = 0
end

function Checker_Base:popIndent()
	assert(#self._stackIndent > 0, "[popIndent] invalid stack balance!")

	self._indentCount = table.remove(self._stackIndent)
end

function Checker_Base:pushMarkLine()
	table.insert(self._stackMarkLineIndex, self:lineCount())
end

function Checker_Base:popMarkLine()
	assert(#self._stackMarkLineIndex > 0, "[popMarkLine]invalid stack balance!")

	return table.remove(self._stackMarkLineIndex)
end

function Checker_Base:appendWithIndex(str, index)
	assert(tonumber(index) ~= nil)

	local n = self:lineCount()
	local s

	self._strBuilder[index] = (index <= 0 or n < index) and self:_validateValue(str) or self._strBuilder[index] .. self:_validateValue(str)
end

function Checker_Base:append(str)
	local index = math.max(1, self:lineCount())

	self:appendWithIndex(str, index)
end

function Checker_Base:appendLine(str)
	table.insert(self._strBuilder, self:_validateValue(str))
end

function Checker_Base:insertLine(index, str)
	index = GameUtil.clamp(index, 1, self:lineCount())

	table.insert(self._strBuilder, self:_validateValue(str), index)
end

function Checker_Base:appendRange(strList)
	if not strList or #strList == 0 then
		return
	end

	for _, v in ipairs(strList) do
		self:appendLine(v)
	end
end

function Checker_Base:move(rChecker_Base)
	if not rChecker_Base then
		return
	end

	local lines = rChecker_Base._strBuilder

	for _, line in ipairs(lines) do
		self:appendLine(line)
	end

	rChecker_Base._strBuilder = {}
end

function Checker_Base:tostring()
	return table.concat(self._strBuilder, "\n")
end

function Checker_Base:_indentStr()
	if self._indentCount <= 0 then
		return ""
	end

	return string.rep("\t", self._indentCount)
end

function Checker_Base:_validateValue(value)
	return self:_indentStr() .. tostring(value)
end

function Checker_Base:log()
	logNormal(self:tostring())
end

return Checker_Base
