-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/controller/PsychicImproveController.lua

module("logic.extensions.psychicimprove.controller.PsychicImproveController", package.seeall)

local PsychicImproveController = class("PsychicImproveController", BaseController)

function PsychicImproveController:onReset()
	return
end

function PsychicImproveController:sendGetInfo(activityId)
	PsychicImproveAgent.instance:sendPM_PsychicImproveGetInfoReq(activityId)
end

function PsychicImproveController:handleGetInfo(msg)
	PsychicImproveModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PsychicImproveInfoUpdate)
end

function PsychicImproveController:sendHidePet(activityId, hireId)
	PsychicImproveAgent.instance:sendPM_PsychicImproveHirePetReq(activityId, hireId)
end

function PsychicImproveController:handleHidePet(msg)
	PsychicImproveModel.instance:onHidePet(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PsychicImproveInfoUpdate)
end

PsychicImproveController.instance = PsychicImproveController.New()

return PsychicImproveController
