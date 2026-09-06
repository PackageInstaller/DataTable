-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/controller/FishingGameController.lua

module("logic.extensions.fishinggame.controller.FishingGameController", package.seeall)

local FishingGameController = class("FishingGameController", BaseController)

function FishingGameController:onInit()
	return
end

function FishingGameController:sendPM_FishingGameGetInfoReq(activityId)
	FishingGameAgent.instance:sendPM_FishingGameGetInfoReq(activityId)
end

function FishingGameController:handlePM_FishingGameGetInfoRes(status, msg)
	if status == 0 then
		FishingGameModel.instance:handlePM_FishingGameGetInfoRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_FishingGameGetInfoRes)
end

function FishingGameController:sendPM_FishingGameStartGameReq(activityId)
	local clientKey = FishingGameModel.instance:getClientKey(activityId)

	FishingGameAgent.instance:sendPM_FishingGameStartGameReq(activityId, clientKey)
end

function FishingGameController:handlePM_FishingGameStartGameRes(status, msg)
	if status == 0 then
		FishingGameModel.instance:handlePM_FishingGameStartGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_FishingGameStartGameRes, status, msg)
end

function FishingGameController:sendPM_FishingGameEndGameReq(activityId, score)
	local clientEncryptedKey = FishingGameModel.instance:getEncryptedKey(activityId, score)

	FishingGameAgent.instance:sendPM_FishingGameEndGameReq(activityId, score, clientEncryptedKey)
end

function FishingGameController:handlePM_FishingGameEndGameRes(status, msg)
	if status == 0 then
		FishingGameModel.instance:handlePM_FishingGameEndGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_FishingGameEndGameRes, status, msg)
end

function FishingGameController:sendPM_FishingGameGainPrizeReq(activityId)
	FishingGameAgent.instance:sendPM_FishingGameGainPrizeReq(activityId)
end

function FishingGameController:handlePM_FishingGameGainPrizeRes(status, msg)
	if status == 0 then
		FishingGameModel.instance:handlePM_FishingGameGainPrizeRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_FishingGameGainPrizeRes)
end

function FishingGameController:sendPM_FishingGameAnnuitySweepReq(activityId, sweepTimes)
	FishingGameAgent.instance:sendPM_FishingGameAnnuitySweepReq(activityId, sweepTimes)
end

function FishingGameController:handlePM_FishingGameAnnuitySweepRes(status, msg)
	if status == 0 then
		FishingGameModel.instance:handlePM_FishingGameAnnuitySweepRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_FishingGameAnnuitySweepRes)
end

FishingGameController.instance = FishingGameController.New()

return FishingGameController
