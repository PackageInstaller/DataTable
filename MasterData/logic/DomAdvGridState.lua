-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/data/DomAdvGridState.lua

module("logic.extensions.domainadventure.data.DomAdvGridState", package.seeall)

local DomAdvGridState = class("DomAdvGridState")

function DomAdvGridState:ctor(activityId, blockId)
	self._activityId = activityId
	self._blockId = blockId
	self._eventType = DomainAdventureConfig.instance:getEventType(activityId, blockId)
	self._fields = {}

	self:onReset()
end

function DomAdvGridState:onReset()
	self._fields.isOccupied = false
	self._fields.isBuff = false
	self._fields.isAdjacentUnlock = false
	self._fields.isAdjacentFire = nil
	self._fields.isRelFatherOcc = nil
	self._fields.isSealFatherOcc = nil
	self._fields.isBossUnlock = nil

	local buffId = DomainAdventureConfig.instance:getBuffIdInGrid(self._activityId, self._blockId)

	self._fields.isBuff = buffId > 0

	if DomAdvPathFindingDataModel.instance:getRelFatherOccIds(self._blockId) then
		self._fields.isRelFatherOcc = false
	end

	if DomAdvPathFindingDataModel.instance:getSealFatherOccIds(self._blockId) then
		self._fields.isSealFatherOcc = false
	end

	if self._eventType == DomAdvEnum.EventType_Boss then
		self._fields.isBossUnlock = false
	end
end

function DomAdvGridState:getBlockId()
	return self._blockId
end

function DomAdvGridState:getEventType()
	return self._eventType
end

function DomAdvGridState:getFields()
	return self._fields
end

function DomAdvGridState:isOccupied()
	return self._fields.isOccupied
end

function DomAdvGridState:setOccupied(value)
	self._fields.isOccupied = value
end

function DomAdvGridState:isBuff()
	return self._fields.isBuff
end

function DomAdvGridState:setBuff(value)
	self._fields.isBuff = value
end

function DomAdvGridState:isAdjacentUnlock()
	return self._fields.isAdjacentUnlock
end

function DomAdvGridState:setAdjacentUnlock(value)
	self._fields.isAdjacentUnlock = value
end

function DomAdvGridState:isAdjacentFire()
	return self._fields.isAdjacentFire
end

function DomAdvGridState:setAdjacentFire(value)
	self._fields.isAdjacentFire = value
end

function DomAdvGridState:isRelFatherOcc()
	return self._fields.isRelFatherOcc
end

function DomAdvGridState:setRelFatherOcc(value)
	self._fields.isRelFatherOcc = value
end

function DomAdvGridState:isSealFatherOcc()
	return self._fields.isSealFatherOcc
end

function DomAdvGridState:setSealFatherOcc(value)
	self._fields.isSealFatherOcc = value
end

function DomAdvGridState:isBossUnlock()
	return self._fields.isBossUnlock
end

function DomAdvGridState:setBossUnlock(value)
	self._fields.isBossUnlock = value
end

return DomAdvGridState
