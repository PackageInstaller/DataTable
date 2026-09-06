-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originwelfare/controller/OriginWelfareController.lua

module("logic.extensions.originwelfare.controller.OriginWelfareController", package.seeall)

local OriginWelfareController = class("OriginWelfareController", BaseController)

function OriginWelfareController:sendPM_OriginWelfareInfoReq(activityId)
	OriginWelfareAgent.instance:sendPM_OriginWelfareInfoReq(activityId)
end

function OriginWelfareController:handlePM_OriginWelfareInfoRes(msg)
	OriginWelfareModel.instance:handlePM_OriginWelfareInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginWelfareInfoRes)
end

function OriginWelfareController:sendPM_OriginWelfareLightUpReq(activityId)
	OriginWelfareAgent.instance:sendPM_OriginWelfareLightUpReq(activityId)
end

function OriginWelfareController:handlePM_OriginWelfareLightUpRes(msg)
	OriginWelfareModel.instance:handlePM_OriginWelfareLightUpRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginWelfareLightUpRes)
end

OriginWelfareController.instance = OriginWelfareController.New()

return OriginWelfareController
