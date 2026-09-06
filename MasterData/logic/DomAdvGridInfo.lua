-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/data/DomAdvGridInfo.lua

module("logic.extensions.domainadventure.data.DomAdvGridInfo", package.seeall)

local DomAdvGridInfo = class("DomAdvGridInfo")

function DomAdvGridInfo:ctor()
	self._activityId = 0
	self._blockId = 0
	self._curProgress = 0
	self._curPercentage = 0
	self._needProgress = 0
	self._occupied = false
	self._maxDamageInFight = 0
end

function DomAdvGridInfo:onReset(activityId, blockId)
	self._activityId = activityId
	self._blockId = blockId
	self._curProgress = 0
	self._curPercentage = 0
	self._occupied = false
	self._maxDamageInFight = 0
	self._eventType = DomainAdventureConfig.instance:getEventType(self._activityId, self._blockId)
	self._needProgress = DomainAdventureConfig.instance:getNeedProgress(self._activityId, self._blockId)
end

function DomAdvGridInfo:updateData(value)
	self._curProgress = checknumber(value.curProgress)

	if self._needProgress <= 0 then
		self._curPercentage = 0
	elseif self._curProgress < self._needProgress then
		local pp = self._curProgress / self._needProgress

		self._curPercentage = 10000 - pp * 10000 < 1 and 0.9999 or checknumber(string.format("%.4f", pp))
	else
		self._curPercentage = 1
	end

	self._occupied = checkbool(value.occupied)

	if self._eventType == DomAdvEnum.EventType_Fight or self._eventType == DomAdvEnum.EventType_EliteFight then
		self._maxDamageInFight = checknumber(value.extParam)
	end
end

function DomAdvGridInfo:updateToOccupied()
	self._curProgress = self._needProgress
	self._curPercentage = 1
	self._occupied = true
end

function DomAdvGridInfo:getBlockId()
	return self._blockId
end

function DomAdvGridInfo:getCurProgress()
	return self._curProgress
end

function DomAdvGridInfo:getCurPercentage()
	return self._curPercentage
end

function DomAdvGridInfo:isOccupied()
	return self._occupied
end

function DomAdvGridInfo:getMaxDamageInFight()
	return self._maxDamageInFight
end

return DomAdvGridInfo
