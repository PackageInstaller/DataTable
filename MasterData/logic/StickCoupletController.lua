-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stickcouplet/controller/StickCoupletController.lua

module("logic.extensions.stickcouplet.controller.StickCoupletController", package.seeall)

local StickCoupletController = class("StickCoupletController", BaseController)

StickCoupletController.leftCoupletType = 1
StickCoupletController.rightCoupletType = 2

function StickCoupletController:getCurProgress(activityId, totalScore)
	local progreesCfg = StickCoupletConfig.instance:getSCProgressData(activityId)
	local process = 0

	for idx, cfg in ipairs(progreesCfg) do
		if totalScore < cfg.needScore then
			process = idx
		end
	end

	return process
end

function StickCoupletController:getActivityType()
	return GameEnum.ActivityType.StickCouplet
end

function StickCoupletController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function StickCoupletController:sendPM_StickCoupletGetInfoReq(activityId)
	StickCoupletAgent.instance:sendPM_StickCoupletGetInfoReq(activityId)
end

function StickCoupletController:handlePM_StickCoupletGetInfoRes(msg)
	StickCoupletModel.instance:handlePM_StickCoupletGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StickCoupletGetInfoRes)
end

function StickCoupletController:sendPM_StickCoupletStartGameReq(activityId)
	local clientKey = StickCoupletModel.instance:getClientKey(activityId)

	StickCoupletAgent.instance:sendPM_StickCoupletStartGameReq(activityId, clientKey)
end

function StickCoupletController:handlePM_StickCoupletStartGameRes(msg)
	StickCoupletModel.instance:handlePM_StickCoupletStartGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StickCoupletStartGameRes)
end

function StickCoupletController:sendPM_StickCoupletEndGameReq(activityId, score)
	local encryptedKey = StickCoupletModel.instance:getEncryptedKey(activityId, score)

	StickCoupletAgent.instance:sendPM_StickCoupletEndGameReq(activityId, score, encryptedKey)
end

function StickCoupletController:handlePM_StickCoupletEndGameRes(msg)
	StickCoupletModel.instance:handlePM_StickCoupletEndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StickCoupletEndGameRes)
end

function StickCoupletController:sendPM_StickCoupletGainPrizeReq(activityId, prizeId)
	StickCoupletAgent.instance:sendPM_StickCoupletGainPrizeReq(activityId, prizeId)
end

function StickCoupletController:handlePM_StickCoupletGainPrizeRes(msg)
	StickCoupletModel.instance:handlePM_StickCoupletGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StickCoupletGainPrizeRes)
end

StickCoupletController.instance = StickCoupletController.New()

return StickCoupletController
