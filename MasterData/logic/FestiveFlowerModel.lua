-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/festiveflower/model/FestiveFlowerModel.lua

module("logic.extensions.festiveflower.model.FestiveFlowerModel", package.seeall)

local FestiveFlowerModel = class("FestiveFlowerModel", BaseModel)

function FestiveFlowerModel:ctor()
	self:onReset()
end

function FestiveFlowerModel:onInit()
	self:onReset()
end

function FestiveFlowerModel:onReset()
	self._gainedPrizeMap = {}
	self._buyTimesMap = {}
	self.ignoreFlowerAnim = true
	self.myScore = 0
end

function FestiveFlowerModel:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(174) or 0
end

function FestiveFlowerModel:handleFestiveFlowerInfoRes(msg)
	self.rankFirst = msg.rankFirst

	local gainedPrizeIds = GameUtil.pbToTable(msg.gainedPrizeIds) or {}

	self._gainedPrizeMap = {}

	for i, id in ipairs(gainedPrizeIds) do
		self._gainedPrizeMap[id] = true
	end

	self.myScore = msg.myScore
end

function FestiveFlowerModel:handleFestiveFlowerFlowerInfoRes(msg)
	local buyTimes = msg.buyTimes

	self._buyTimesMap = {}

	for i, info in ipairs(buyTimes) do
		self._buyTimesMap[info.flowerId] = info.buyTimes
	end
end

function FestiveFlowerModel:getBuyTime(flowerId)
	return self._buyTimesMap[flowerId] or 0
end

function FestiveFlowerModel:beforeBuyFlower(flowerId)
	self._cacheBuyFlowerId = flowerId
end

function FestiveFlowerModel:handleFestiveFlowerBuyFlowerRes(msg)
	self._buyTimesMap[self._cacheBuyFlowerId] = self._buyTimesMap[self._cacheBuyFlowerId] or self._buyTimesMap[self._cacheBuyFlowerId] + 1
end

function FestiveFlowerModel:beforeGainPrize(prizeId)
	self._cachePrizeId = prizeId
end

function FestiveFlowerModel:handleFestiveFlowerGainPrizeRes(msg)
	self._gainedPrizeMap[self._cachePrizeId] = true
end

function FestiveFlowerModel:handleNotifyGainFreeFlowerRes(msg)
	self._buyTimesMap[1] = 1
end

function FestiveFlowerModel:isRewardCanGet(prizeId, needScore)
	local isScoreEnough = needScore <= self.myScore

	if isScoreEnough then
		local isGeted = self:isRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function FestiveFlowerModel:isRewardGeted(prizeId)
	return self._gainedPrizeMap[prizeId] == true
end

FestiveFlowerModel.instance = FestiveFlowerModel.New()

return FestiveFlowerModel
