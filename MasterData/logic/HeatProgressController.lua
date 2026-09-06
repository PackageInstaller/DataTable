-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heatprogress/controller/HeatProgressController.lua

module("logic.extensions.heatprogress.controller.HeatProgressController", package.seeall)

local HeatProgressController = class("HeatProgressController", BaseController)

function HeatProgressController:ctor()
	return
end

function HeatProgressController:onInit()
	return
end

function HeatProgressController:onReset()
	return
end

function HeatProgressController:onSendProgressGetInfoReq(activityId)
	HeatProgressAgent.instance:sendPM_SummaryProgressGetInfoReq(activityId)
end

function HeatProgressController:onHandleProgressGetInfoRes(msg)
	HeatProgressModel.instance:onHandleProgressGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HeatProgressOnUpdatePlanCfg)
end

function HeatProgressController:onSendProgressGainPrizeReq(activityId, progressId, id)
	HeatProgressAgent.instance:sendPM_SummaryProgressGainPrizeReq(activityId, progressId, id)
end

function HeatProgressController:onHandleProgressGainPrizeRes(msg)
	HeatProgressModel.instance:onHandleProgressGainPrizeRes(msg)

	local changeSetId = HeatProgressModel.instance._prizeRes.changeSetId

	MaterialController.instance:saveChangeSetToTemp(changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.HeatProgressGainPrize)
end

HeatProgressController.instance = HeatProgressController.New()

return HeatProgressController
