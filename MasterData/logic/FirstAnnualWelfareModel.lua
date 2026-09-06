-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstannualwelfare/model/FirstAnnualWelfareModel.lua

module("logic.extensions.firstannualwelfare.model.FirstAnnualWelfareModel", package.seeall)

local FirstAnnualWelfareModel = class("FirstAnnualWelfareModel", BaseModel)

function FirstAnnualWelfareModel:ctor()
	return
end

function FirstAnnualWelfareModel:onInit()
	self:onReset()
end

function FirstAnnualWelfareModel:onReset()
	self._activityId = 0
	self._gainFreeGoldenCard = false
	self._gainSkinCard = false
	self._exchangeTimes = {}
end

function FirstAnnualWelfareModel:onHandleFirstAnnualWelfareGetInfoRes(msg)
	self._activityId = checknumber(msg.activityId)
	self._gainFreeGoldenCard = msg.gainFreeGoldenCard
	self._gainSkinCard = msg.gainSkinCard
	self._exchangeTimes = {}

	for exchangeIndex, times in ipairs(msg.exchangeTimes) do
		self._exchangeTimes[exchangeIndex] = checknumber(times)
	end
end

function FirstAnnualWelfareModel:onHandleFirstAnnualWelfareGainFreeGoldenCardRes(msg)
	self._gainFreeGoldenCard = true
end

function FirstAnnualWelfareModel:onHandleFirstAnnualWelfareExchangeRes(msg)
	self._activityId = checknumber(msg.activityId)

	local exchangeIndex = checknumber(msg.exchangeIndex)

	self._exchangeTimes[exchangeIndex] = self._exchangeTimes[exchangeIndex] + 1
end

function FirstAnnualWelfareModel:onHandleFirstAnnualWelfareGainPetSkinRes(msg)
	self._gainSkinCard = true
end

function FirstAnnualWelfareModel:getActivityId()
	return self._activityId
end

function FirstAnnualWelfareModel:getExchangeTimes()
	return self._exchangeTimes
end

function FirstAnnualWelfareModel:getExchangeTimesByIdx(exchangeIndex)
	return self._exchangeTimes[exchangeIndex] or 0
end

function FirstAnnualWelfareModel:getGainFreeGoldenCard()
	return self._gainFreeGoldenCard
end

function FirstAnnualWelfareModel:getGainSkinCard()
	return self._gainSkinCard
end

FirstAnnualWelfareModel.instance = FirstAnnualWelfareModel.New()

return FirstAnnualWelfareModel
