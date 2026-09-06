-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclemultiplied/controller/MiracleMultipliedController.lua

module("logic.extensions.miraclemultiplied.controller.MiracleMultipliedController", package.seeall)

local MiracleMultipliedController = class("MiracleMultipliedController", BaseController)

function MiracleMultipliedController:ctor()
	return
end

function MiracleMultipliedController:onInit()
	return
end

function MiracleMultipliedController:onReset()
	return
end

function MiracleMultipliedController:sendPM_MiracleMultipliedGetInfoReq(activityId)
	MiracleMultipliedAgent.instance:sendPM_MiracleMultipliedGetInfoReq(activityId)
end

function MiracleMultipliedController:handlePM_MiracleMultipliedGetInfoRes(msg)
	local mo = self:getMiracleMultipliedMo(msg.activityId)

	mo:handlePM_MiracleMultipliedGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MiracleMultipliedGetInfoRes)
end

function MiracleMultipliedController:sendPM_MiracleMultipliedUnlockReq(activityId, collectId)
	MiracleMultipliedAgent.instance:sendPM_MiracleMultipliedUnlockReq(activityId, collectId)
end

function MiracleMultipliedController:handlePM_MiracleMultipliedUnlockRes(msg)
	local mo = self:getMiracleMultipliedMo(msg.activityId)

	mo:handlePM_MiracleMultipliedUnlockRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MiracleMultipliedUnlockRes)
end

function MiracleMultipliedController:sendPM_MiracleMultipliedGainPrizeReq(activityId, collectId)
	MiracleMultipliedAgent.instance:sendPM_MiracleMultipliedGainPrizeReq(activityId, collectId)
end

function MiracleMultipliedController:handlePM_MiracleMultipliedGainPrizeRes(msg)
	local mo = self:getMiracleMultipliedMo(msg.activityId)

	mo:handlePM_MiracleMultipliedGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MiracleMultipliedGainPrizeRes)
end

function MiracleMultipliedController:getMiracleMultipliedMo(activityId)
	return MiracleMultipliedModel.instance:getMiracleMultipliedMo(activityId)
end

function MiracleMultipliedController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function MiracleMultipliedController:getActivityType()
	return GameEnum.ActivityType.MiracleMultiplied
end

function MiracleMultipliedController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

MiracleMultipliedController.instance = MiracleMultipliedController.New()

return MiracleMultipliedController
