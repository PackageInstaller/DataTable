-- chunkname: @modules/logic/versionactivity3_7/wmz/model/WmzMapStart.lua

module("modules.logic.versionactivity3_7.wmz.model.WmzMapStart", package.seeall)

local WmzMapStart = class("WmzMapStart", WmzMapGridBase)

function WmzMapStart:ctor(...)
	WmzMapStart.super.ctor(self, ...)
end

function WmzMapStart:isTile()
	return false
end

function WmzMapStart:isStart()
	return true
end

function WmzMapStart:isWall()
	return false
end

function WmzMapStart:isPassable()
	return false
end

function WmzMapStart:isEmpty()
	return false
end

function WmzMapStart:getTile()
	return nil
end

function WmzMapStart:in_ZoneMask()
	return self:_in_ZoneMask_default()
end

function WmzMapStart:out_ZoneMask()
	return self:_out_ZoneMask_default()
end

function WmzMapStart:setSelected(bSelected)
	if isDebugBuild then
		assert(false, "[setSelected] invalid call")
	end
end

function WmzMapStart:bSelected()
	return false
end

function WmzMapStart:tileId()
	return -1
end

function WmzMapStart:setTileId(tileId)
	if isDebugBuild then
		assert(false, "[setTileId] invalid call")
	end
end

return WmzMapStart
