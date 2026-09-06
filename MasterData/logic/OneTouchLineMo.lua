-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/model/OneTouchLineMo.lua

module("logic.extensions.luoshiqiordeal.model.OneTouchLineMo", package.seeall)

local OneTouchLineMo = class("OneTouchLineMo")

function OneTouchLineMo:ctor(row, column)
	self:init(row, column)
end

function OneTouchLineMo:init(row, column)
	self.startIndex = 0
	self.endIndex = 0
	self._maxRow = row
	self._maxColumn = column
end

function OneTouchLineMo:setStartIndex(index)
	self.startIndex = index
end

function OneTouchLineMo:setEndIndex(index)
	self.endIndex = index
end

function OneTouchLineMo:getStartIndex()
	return self.startIndex
end

function OneTouchLineMo:getEndIndex()
	return self.endIndex
end

function OneTouchLineMo:getSortIndex()
	if self.startIndex <= self.endIndex then
		return self.startIndex, self.endIndex
	else
		return self.endIndex, self.startIndex
	end
end

function OneTouchLineMo:isStartEqualEnd()
	return self.startIndex == self.endIndex
end

function OneTouchLineMo:isHorizontal()
	local startX = Mathf.Floor(self.startIndex / self._maxColumn)
	local endX = Mathf.Floor(self.endIndex / self._maxColumn)

	return startX == endX
end

return OneTouchLineMo
