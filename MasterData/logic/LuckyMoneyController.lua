-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckymoney/controller/LuckyMoneyController.lua

module("logic.extensions.luckymoney.model.LuckyMoneyController", package.seeall)

local LuckyMoneyController = class("LuckyMoneyController", BaseController)

function LuckyMoneyController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function LuckyMoneyController:getActivityType()
	return GameEnum.ActivityType.LuckyMoney
end

function LuckyMoneyController:isInActivityTime()
	local activityType = self:getActivityType()
	local activityId = self:getActivityId()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function LuckyMoneyController:sendPM_LuckyMoneyGetInfoReq(activityId)
	LuckyMoneyAgent.instance:sendPM_LuckyMoneyGetInfoReq(activityId)
end

function LuckyMoneyController:handlePM_LuckyMoneyGetInfoRes(msg)
	LuckyMoneyModel.instance:handlePM_LuckyMoneyGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LuckyMoneyGetInfoRes)
end

function LuckyMoneyController:sendPM_LuckyMoneyActEndReq(activityId, score)
	LuckyMoneyAgent.instance:sendPM_LuckyMoneyActEndReq(activityId, score)
end

function LuckyMoneyController:handlePM_LuckyMoneyActEndRes(msg)
	LuckyMoneyModel.instance:handlePM_LuckyMoneyActEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LuckyMoneyActEndRes)
end

function LuckyMoneyController:sendPM_LuckyMoneyGainProgressPrizeReq(activityId, dataBitId)
	LuckyMoneyAgent.instance:sendPM_LuckyMoneyGainProgressPrizeReq(activityId, dataBitId)
end

function LuckyMoneyController:handlePM_LuckyMoneyGainProgressPrizeRes(msg)
	LuckyMoneyModel.instance:handlePM_LuckyMoneyGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LuckyMoneyGainProgressPrizeRes)
end

function LuckyMoneyController:canGetScore()
	local activityId = self:getActivityId()
	local playerTotalScore = LuckyMoneyModel.instance:getPlayerTotalScore(activityId)
	local maxScore = LuckyMoneyConfig.instance:getMaxRewardScore(activityId)

	return playerTotalScore <= maxScore
end

LuckyMoneyController.instance = LuckyMoneyController.New()

return LuckyMoneyController
