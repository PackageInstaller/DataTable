-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huanxinqing/controller/HuanXinQingController.lua

module("logic.extensions.huanxinqing.controller.HuanXinQingController", package.seeall)

local HuanXinQingController = class("HuanXinQingController", BaseController)

function HuanXinQingController:ctor()
	return
end

function HuanXinQingController:onInit()
	return
end

function HuanXinQingController:onReset()
	return
end

function HuanXinQingController:sendPM_PetActiveGetInfoReq(activityId)
	HuanXinQingAgent.instance:sendPM_PetActiveGetInfoReq(activityId)
end

function HuanXinQingController:handlePM_PetActiveGetInfoRes(msg)
	HuanXinQingModel.instance:handlePM_PetActiveGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_PetActiveGetInfoRes)
end

function HuanXinQingController:sendPM_PetActiveGetUnlockReq(activityId, itemId)
	HuanXinQingAgent.instance:sendPM_PetActiveGetUnlockReq(activityId, itemId)
end

function HuanXinQingController:handlePM_PetActiveGetUnlockRes(msg)
	HuanXinQingModel.instance:handlePM_PetActiveGetUnlockRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_PetActiveGetUnlockRes)
end

function HuanXinQingController:sendPM_PetActiveGetDirectBuyReq(activityId)
	HuanXinQingAgent.instance:sendPM_PetActiveGetDirectBuyReq(activityId)
end

function HuanXinQingController:handlePM_PetActiveGetDirectBuyRes(msg)
	HuanXinQingModel.instance:handlePM_PetActiveGetDirectBuyRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_PetActiveGetDirectBuyRes)
end

function HuanXinQingController:sendPM_PetActiveGetExchangePropReq(activityId, propId, num)
	HuanXinQingAgent.instance:sendPM_PetActiveGetExchangePropReq(activityId, propId, num)
end

function HuanXinQingController:handlePM_PetActiveGetExchangePropRes(msg)
	HuanXinQingModel.instance:handlePM_PetActiveGetExchangePropRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_PetActiveGetExchangePropRes)
end

function HuanXinQingController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function HuanXinQingController:getSkinId(activityId)
	return HuanXinQingConfig.instance:getCommonData(activityId).skinId
end

function HuanXinQingController:getActivityType()
	return GameEnum.ActivityType.PetActiveGet
end

function HuanXinQingController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

HuanXinQingController.instance = HuanXinQingController.New()

return HuanXinQingController
