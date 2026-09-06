-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/relationpower/controller/RelationPowerController.lua

module("logic.extensions.relationpower.controller.RelationPowerController", package.seeall)

local RelationPowerController = class("RelationPowerController", BaseController)

function RelationPowerController:ctor()
	return
end

function RelationPowerController:onReset()
	return
end

function RelationPowerController:getInfo(actId)
	RelationPowerAgent.instance:sendPM_RelationPowerGetInfoReq(actId)
end

function RelationPowerController:handleGetInfo(msg)
	RelationPowerModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RelationPowerGetInfo)
end

function RelationPowerController:verifyPower(actId, formId, form)
	RelationPowerAgent.instance:sendPM_RelationPowerVerifyReq(actId, formId, form)
end

function RelationPowerController:handleVerifyPower(msg)
	RelationPowerModel.instance:onVerifyPower(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RelationPowerVerify)
end

function RelationPowerController:gainPrize(actId, taskId)
	RelationPowerModel.instance:gainTaskPrize(taskId)
	RelationPowerAgent.instance:sendPM_RelationPowerGainTaskPrizeReq(actId, taskId)
end

function RelationPowerController:handleGainPrize(msg)
	RelationPowerModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RelationPowerGainPrize)
end

function RelationPowerController:_onError(status)
	return
end

RelationPowerController.instance = RelationPowerController.New()

return RelationPowerController
