-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zdlverify/controller/ZdlVerifyController.lua

module("logic.extensions.zdlverify.controller.ZdlVerifyController", package.seeall)

local ZdlVerifyController = class("ZdlVerifyController", BaseController)

function ZdlVerifyController:onInit()
	self:onReset()
end

function ZdlVerifyController:onReset()
	return
end

function ZdlVerifyController:getDefaultActivityId()
	return 614001
end

function ZdlVerifyController:getInfo(activityId)
	ZdlVerifyAgent.instance:sendPM_ZdlVerifyInfoReq(activityId)
end

function ZdlVerifyController:handlePM_ZdlVerifyInfoRes(msg)
	ZdlVerifyModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ZdlVerifyInfoRes)
end

function ZdlVerifyController:verifyRace(activityId, verifyId, petId)
	ZdlVerifyAgent.instance:sendPM_ZdlVerifyVerifyRaceReq(activityId, verifyId, petId)
end

function ZdlVerifyController:handlePM_ZdlVerifyVerifyRaceRes(msg)
	ZdlVerifyModel.instance:onVerifyRace(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ZdlVerifyVerifyRaceRes)
end

function ZdlVerifyController:gainProgress(activityId, progressId)
	ZdlVerifyAgent.instance:sendPM_ZdlVerifyGainProgressReq(activityId, progressId)
end

function ZdlVerifyController:handlePM_ZdlVerifyGainProgressRes(msg)
	ZdlVerifyModel.instance:onGainProgress(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ZdlVerifyGainProgressRes)
end

ZdlVerifyController.instance = ZdlVerifyController.New()

return ZdlVerifyController
