-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternriddle/controller/LanternRiddleController.lua

module("logic.extensions.guesslantern.controller.LanternRiddleController", package.seeall)

local LanternRiddleController = class("LanternRiddleController", BaseController)

function LanternRiddleController:sendPM_LanternRiddleGetInfoReq(activityId)
	LanternRiddleAgent.instance:sendPM_LanternRiddleGetInfoReq(activityId)
end

function LanternRiddleController:handlePM_LanternRiddleGetInfoRes(msg)
	LanternRiddleModel.instance:handlePM_LanternRiddleGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LanternRiddleGetInfoRes)
end

function LanternRiddleController:sendPM_LanternRiddleStartGameReq(activityId, stageId)
	local clientKey = LanternRiddleModel.instance:getClientKey(activityId)

	LanternRiddleAgent.instance:sendPM_LanternRiddleStartGameReq(activityId, stageId, clientKey)
end

function LanternRiddleController:handlePM_LanternRiddleStartGameRes(msg)
	LanternRiddleModel.instance:handlePM_LanternRiddleStartGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LanternRiddleStartGameRes)
end

function LanternRiddleController:sendPM_LanternRiddleEndGameReq(activityId, stageId, pass, problemId)
	if problemId then
		local encryptedKey = LanternRiddleModel.instance:getEncryptedKey(activityId, stageId, pass, problemId)

		LanternRiddleAgent.instance:sendPM_LanternRiddleEndGameReq(activityId, stageId, pass, encryptedKey, problemId)
	else
		local encryptedKey = LanternRiddleModel.instance:getEncryptedKey(activityId, stageId, pass)

		LanternRiddleAgent.instance:sendPM_LanternRiddleEndGameReq(activityId, stageId, pass, encryptedKey, 0)
	end
end

function LanternRiddleController:handlePM_LanternRiddleEndGameRes(msg)
	LanternRiddleModel.instance:handlePM_LanternRiddleEndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LanternRiddleEndGameRes)
end

function LanternRiddleController:sendPM_LanternRiddleGainPrizeReq(activityId, prizeId)
	LanternRiddleAgent.instance:sendPM_LanternRiddleGainPrizeReq(activityId, prizeId)
end

function LanternRiddleController:handlePM_LanternRiddleGainPrizeRes(msg)
	LanternRiddleModel.instance:handlePM_LanternRiddleGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LanternRiddleGainPrizeRes)
end

function LanternRiddleController:getActivityType()
	return GameEnum.ActivityType.LanternRiddle
end

function LanternRiddleController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

LanternRiddleController.instance = LanternRiddleController.New()

return LanternRiddleController
