-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerholidayscheckin/model/SummerholidayscheckinModel.lua

module("logic.extensions.summerholidayscheckin.view.SummerholidayscheckinModel", package.seeall)

local SummerholidayscheckinModel = class("SummerholidayscheckinModel", BaseModel)

function SummerholidayscheckinModel:ctor()
	return
end

function SummerholidayscheckinModel:onInit()
	self:onReset()
end

function SummerholidayscheckinModel:onReset()
	self._info = nil
	self._prizeGain = {}
end

function SummerholidayscheckinModel:setInfo(msg)
	self._info = msg

	for i, prizeId in ipairs(msg.gainPrizeIds) do
		self._prizeGain[prizeId] = true
	end
end

function SummerholidayscheckinModel:getTodayCheckInTimes()
	if self._info then
		return self._info.todayCheckInTimes
	end

	return 0
end

function SummerholidayscheckinModel:addCheckInTimes(activityId)
	if self._info and self._info.activityId == activityId then
		self._info.todayCheckInTimes = self._info.todayCheckInTimes + 1
		self._info.checkInDays = self._info.checkInDays + 1
	end
end

function SummerholidayscheckinModel:getCheckInDays()
	if self._info then
		return self._info.checkInDays
	end

	return 0
end

function SummerholidayscheckinModel:isGainPrize(prizeId)
	return self._prizeGain[prizeId]
end

function SummerholidayscheckinModel:addGainPrize(prizeIds)
	for _, prizeId in ipairs(prizeIds or {}) do
		self._prizeGain[prizeId] = true
	end
end

SummerholidayscheckinModel.instance = SummerholidayscheckinModel.New()

return SummerholidayscheckinModel
