-- chunkname: @modules/logic/versionactivity3_7/wmz/model/WmzMapCell.lua

module("modules.logic.versionactivity3_7.wmz.model.WmzMapCell", package.seeall)

local WmzMapCell = class("WmzMapCell", WmzMapGridBase)

function WmzMapCell:ctor(...)
	WmzMapCell.super.ctor(self, ...)
end

function WmzMapCell:isTile()
	return false
end

function WmzMapCell:isStart()
	return false
end

function WmzMapCell:isEmpty()
	local bEmpty = WmzMapCell.super.isEmpty(self)

	if self._tileId == -1 then
		return bEmpty
	end

	local tileObj = self:getTile()

	if isDebugBuild then
		assert(tileObj, "[isEmpty] invalid call: " .. self:indexStr())
	end

	return false
end

function WmzMapCell:setWelded(bWelded)
	local tileObj = self:getTile()

	if tileObj then
		tileObj:setWelded(bWelded)

		return
	end

	self._bWelded = bWelded
end

function WmzMapCell:bWelded()
	local tileObj = self:getTile()

	if tileObj then
		return tileObj:bWelded()
	end

	return self._bWelded
end

function WmzMapCell:setSelected(bSelected)
	local tileObj = self:getTile()

	if isDebugBuild then
		assert(tileObj, "[setSelected] invalid call: " .. self:indexStr())
	end

	if not tileObj then
		return
	end

	tileObj:setSelected(bSelected)
end

function WmzMapCell:bSelected()
	local tileObj = self:getTile()

	if not tileObj then
		return false
	end

	return tileObj:bSelected()
end

function WmzMapCell:groupId()
	local tileObj = self:getTile()

	if tileObj then
		return tileObj:groupId()
	end

	return self._cellInfo.groupId or 0
end

return WmzMapCell
