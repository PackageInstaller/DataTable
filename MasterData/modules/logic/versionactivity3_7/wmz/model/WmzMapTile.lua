-- chunkname: @modules/logic/versionactivity3_7/wmz/model/WmzMapTile.lua

local sf = string.format

module("modules.logic.versionactivity3_7.wmz.model.WmzMapTile", package.seeall)

local WmzMapTile = class("WmzMapTile", WmzMapGridBase)

function WmzMapTile:ctor(...)
	WmzMapTile.super.ctor(self, ...)
end

function WmzMapTile:isTile()
	return true
end

function WmzMapTile:getTile()
	return self
end

function WmzMapTile:isStart()
	return false
end

function WmzMapTile:isWall()
	return false
end

function WmzMapTile:isVoid()
	return false
end

function WmzMapTile:isEmpty()
	return false
end

function WmzMapTile:isPassable()
	return false
end

function WmzMapTile:tileId()
	return self:id()
end

function WmzMapTile:in_ZoneMask()
	return self:_in_ZoneMask_default()
end

function WmzMapTile:out_ZoneMask()
	return self:_out_ZoneMask_default()
end

function WmzMapTile:unbind()
	local lastCellObj = self:getCell(self.index:Get())

	assert(lastCellObj, sf("invalid cell (%s, %s)", self.index:Get()))
	lastCellObj:setTileId(-1)
end

function WmzMapTile:bind(x, y)
	local curCellObj = self:getCell(x, y)

	assert(curCellObj, sf("invalid cell (%s, %s)", x, y))
	self.index:Set(x, y)
	curCellObj:setTileId(self:tileId())
end

function WmzMapTile:resetToInit()
	self.index:Set(self._cellInfo.x, self._cellInfo.y)

	self._tileId = -1
	self._bWelded = false
	self._bSelected = false
end

function WmzMapTile:finalSprite()
	local cellObj = self:getCell(self.index:Get())

	if cellObj then
		return cellObj:finalSprite()
	end

	return self._cellInfo._fSprite or self:sprite()
end

return WmzMapTile
