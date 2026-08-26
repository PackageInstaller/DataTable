-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/mo/RogueEndingInfoMO.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueEndingInfoMO", package.seeall)

local RogueEndingInfoMO = pureTable("RogueEndingInfoMO")

function RogueEndingInfoMO:init(info)
	self._activityId = info.activityId
	self._difficulty = info.difficulty
	self._heros = info.heroId
	self._roomId = info.roomId
	self._roomNum = info.roomNum
	self._currencyTotal = info.currencyTotal
	self._collections = info.collections
	self._isFinish = info.isFinish
	self._score = info.score
	self._doubleScore = info.doubleScore
	self._bonus = info.bonus
	self._ending = info.ending
	self._layer = info.layer
	self._failReason = info.failReason

	self:initFinishEvents(info)

	self._isEnterEndingFlow = false
end

function RogueEndingInfoMO:initFinishEvents(info)
	local events = info.finishEvents

	self.finishEventList = self.finishEventList or {}

	tabletool.clear(self.finishEventList)

	if events then
		for _, finishEventId in ipairs(events) do
			table.insert(self.finishEventList, finishEventId)
		end
	end
end

function RogueEndingInfoMO:getFinishEventList()
	return self.finishEventList
end

function RogueEndingInfoMO:getFinishEventNum()
	return (self.finishEventList or nil) and (#self.finishEventList or 0)
end

function RogueEndingInfoMO:getLayer()
	return self._layer
end

function RogueEndingInfoMO:getRoomNum()
	return self._roomNum
end

function RogueEndingInfoMO:getDifficulty()
	return self._difficulty
end

function RogueEndingInfoMO:getScore()
	return self._score
end

function RogueEndingInfoMO:isDoubleScore()
	return self._doubleScore > 0
end

function RogueEndingInfoMO:isFinish()
	return self._isFinish
end

function RogueEndingInfoMO:getFailReason()
	return self._failReason
end

function RogueEndingInfoMO:onEnterEndingFlow()
	self._isEnterEndingFlow = true
end

function RogueEndingInfoMO:isEnterEndingFlow()
	return self._isEnterEndingFlow
end

return RogueEndingInfoMO
