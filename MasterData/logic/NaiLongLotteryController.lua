-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/controller/NaiLongLotteryController.lua

module("logic.extensions.nailonglottery.controller.NaiLongLotteryController", package.seeall)

local NaiLongLotteryController = class("NaiLongLotteryController", BaseController)

function NaiLongLotteryController:onInit()
	return
end

function NaiLongLotteryController:onReset()
	return
end

function NaiLongLotteryController:sendPM_ShareLotteryGetInfoReq(activityId)
	ShareLotteryAgent.instance:sendPM_ShareLotteryGetInfoReq(activityId)
end

function NaiLongLotteryController:handlePM_ShareLotteryGetInfoRes(msg)
	local mo = self:getNaiLongLotteryMo(msg.activityId)

	mo:handlePM_ShareLotteryGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShareLotteryGetInfoRes)
end

function NaiLongLotteryController:sendPM_ShareLotteryLotteryReq(activityId)
	ShareLotteryAgent.instance:sendPM_ShareLotteryLotteryReq(activityId)
end

function NaiLongLotteryController:handlePM_ShareLotteryLotteryRes(status, msg)
	if status == 0 then
		local mo = self:getNaiLongLotteryMo(msg.activityId)

		mo:handlePM_ShareLotteryLotteryRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShareLotteryLotteryRes, status, msg)
end

function NaiLongLotteryController:sendPM_ShareLotteryShareReq(activityId)
	ShareLotteryAgent.instance:sendPM_ShareLotteryShareReq(activityId)
end

function NaiLongLotteryController:handlePM_ShareLotteryShareRes(msg)
	local mo = self:getNaiLongLotteryMo(msg.activityId)

	mo:handlePM_ShareLotteryShareRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShareLotteryShareRes, msg)
end

function NaiLongLotteryController:sendPM_ShareLotteryGainPrizeReq(activityId, prizeIds)
	ShareLotteryAgent.instance:sendPM_ShareLotteryGainPrizeReq(activityId, prizeIds)
end

function NaiLongLotteryController:handlePM_ShareLotteryGainPrizeRes(msg)
	local mo = self:getNaiLongLotteryMo(msg.activityId)

	mo:handlePM_ShareLotteryGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShareLotteryGainPrizeRes)
end

function NaiLongLotteryController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function NaiLongLotteryController:getActivityType()
	return GameEnum.ActivityType.NaiLongLottery
end

function NaiLongLotteryController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function NaiLongLotteryController:getNaiLongLotteryMo(activityId)
	return NaiLongLotteryModel.instance:getNaiLongLotteryMo(activityId)
end

NaiLongLotteryController.instance = NaiLongLotteryController.New()

return NaiLongLotteryController
