-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/disorderpower/controller/DisOrderPowerController.lua

module("logic.extensions.disorderpower.controller.DisOrderPowerController", package.seeall)

local DisOrderPowerController = class("DisOrderPowerController", BaseController)

function DisOrderPowerController:ctor()
	return
end

function DisOrderPowerController:onInit()
	return
end

function DisOrderPowerController:onReset()
	return
end

function DisOrderPowerController:sendPM_DisorderPowerGetInfoReq(activityId)
	DisOrderPowerAgent.instance:sendPM_DisorderPowerGetInfoReq(activityId)
end

function DisOrderPowerController:handlePM_DisorderPowerGetInfoRes(msg)
	DisOrderPowerModel.instance:handlePM_DisorderPowerGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DisorderPowerGetInfoRes)
end

function DisOrderPowerController:sendPM_DisorderPowerLotteryReq(activityId)
	DisOrderPowerAgent.instance:sendPM_DisorderPowerLotteryReq(activityId)
end

function DisOrderPowerController:handlePM_DisorderPowerLotteryRes(msg)
	DisOrderPowerModel.instance:handlePM_DisorderPowerLotteryRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DisorderPowerLotteryRes)
end

function DisOrderPowerController:sendPM_DisorderPowerFightReq(activityId, form)
	DisOrderPowerAgent.instance:sendPM_DisorderPowerFightReq(activityId, form)
end

function DisOrderPowerController:handlePM_DisorderPowerNotifyFightRes(msg)
	DisOrderPowerModel.instance:handlePM_DisorderPowerNotifyFightRes(msg)
end

function DisOrderPowerController:sendPM_DisorderPowerGainPrizeReq(activityId, prizeId)
	DisOrderPowerAgent.instance:sendPM_DisorderPowerGainPrizeReq(activityId, prizeId)
end

function DisOrderPowerController:handlePM_DisorderPowerGainPrizeRes(msg)
	DisOrderPowerModel.instance:handlePM_DisorderPowerGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DisorderPowerGainPrizeRes)
end

function DisOrderPowerController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DisOrderPowerController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function DisOrderPowerController:enterBattleClg(activityId, cardId)
	local customNorFmtMo = DisOrderPowerModel.instance:getFmtMo(activityId)

	customNorFmtMo:updateCfg(activityId, cardId)
	CustomFmtController.instance:showMissionView(customNorFmtMo)
end

DisOrderPowerController.instance = DisOrderPowerController.New()

return DisOrderPowerController
