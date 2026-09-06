-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partyprize/model/PartyPrizeModel.lua

module("logic.extensions.partyprize.model.PartyPrizeModel", package.seeall)

local PartyPrizeModel = class("PartyPrizeModel", BaseModel)

function PartyPrizeModel:ctor()
	PartyPrizeModel.super.ctor(self)
end

function PartyPrizeModel:onInit()
	self:onReset()
end

function PartyPrizeModel:onReset()
	self._onlineDay = 0
	self._hasGainPrizeDays = nil
	self._hasGainedAccumulate = false
	self._hasGainedDaily = nil
end

function PartyPrizeModel:initData(msg)
	print("init partyprize model")

	self._onlineDay = msg.onlineDay
	self._hasGainPrizeDays = msg.hasGainPrizeDays
	self._hasGainedAccumulate = msg.hasGainedAccumulate
	self._hasGainedDaily = msg.hasGainedDaily
end

function PartyPrizeModel:gainPrize(idx, msg)
	self._hasGainPrizeDays[idx] = true
end

function PartyPrizeModel:gainAccumulatePrize(msg)
	self._hasGainedAccumulate = true
end

function PartyPrizeModel:gainDailyPrize(idx, msg)
	self._hasGainedDaily[idx] = true
end

function PartyPrizeModel:checkCanGainPrize(i)
	return self._hasGainPrizeDays[i] ~= true and i <= self._onlineDay and not self:isEndSignin()
end

function PartyPrizeModel:checkCanGainAnyPrize()
	for i = 1, 7 do
		if checkCanGainPrize(i) then
			return true
		end
	end

	return false
end

function PartyPrizeModel:countGainPrizeDays()
	local countGainPrize = 0

	for i = 1, 7 do
		if self._hasGainPrizeDays[i] then
			countGainPrize = countGainPrize + 1
		end
	end

	return countGainPrize
end

function PartyPrizeModel:hasGainAccumulate()
	return self._hasGainedAccumulate
end

function PartyPrizeModel:hasGainPrizeDays(i)
	return self._hasGainPrizeDays[i]
end

function PartyPrizeModel:isEndSignin()
	local now = ServerTime.now()
	local checkInEndTime = GameUtil.string2time(PartyPrizeConfig.instance:getCfg().checkInEndTime)

	return checkInEndTime <= now
end

function PartyPrizeModel:checkCanGainAccumulateNow()
	return self:isEndSignin()
end

function PartyPrizeModel:checkCanGainAccumulateCondition()
	local accumulateDays = PartyPrizeConfig.instance:getCfg().accumulateDays

	return accumulateDays <= self:countGainPrizeDays()
end

function PartyPrizeModel:checkCanGainAccumulate()
	return self:checkCanGainAccumulateNow() and self:checkCanGainAccumulateCondition() and self._hasGainedAccumulate ~= true
end

function PartyPrizeModel:checkCanGainDailyPrize(idx)
	return self._hasGainedDaily[idx] ~= true
end

PartyPrizeModel.instance = PartyPrizeModel.New()

return PartyPrizeModel
