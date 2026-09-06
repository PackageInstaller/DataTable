-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/geargame/controller/GearGameController.lua

module("logic.extensions.geargame.controller.GearGameController", package.seeall)

local GearGameController = class("GearGameController", BaseController)

function GearGameController:onInit()
	self:onReset()
end

function GearGameController:onReset()
	return
end

function GearGameController:sendPM_GearGameInfoReq(activityId)
	GearGameAgent.instance:sendPM_GearGameInfoReq(activityId)
end

function GearGameController:handlePM_GearGameInfoRes(status, msg)
	if status == 0 then
		GearGameModel.instance:handlePM_GearGameInfoRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_GearGameInfoRes)
end

function GearGameController:sendPM_GearGameStartGameReq(activityId)
	local clientKey = GearGameModel.instance:getClientKey(activityId)

	GearGameAgent.instance:sendPM_GearGameStartGameReq(activityId, clientKey)
end

function GearGameController:handlePM_GearGameStartGameRes(status, msg)
	if status == 0 then
		GearGameModel.instance:handlePM_GearGameStartGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_GearGameStartGameRes)
end

function GearGameController:sendPM_GearGameEndGameReq(activityId, stageId, passOrNot)
	GearGameModel.instance:pushHasPassResult(activityId, passOrNot)

	local encryptedKey = GearGameModel.instance:getEncryptedKey(activityId, passOrNot)

	GearGameAgent.instance:sendPM_GearGameEndGameReq(activityId, stageId, passOrNot, encryptedKey)
end

function GearGameController:handlePM_GearGameEndGameRes(status, msg)
	if status == 0 then
		GearGameModel.instance:handlePM_GearGameEndGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_GearGameEndGameRes)
end

GearGameController.instance = GearGameController.New()

return GearGameController
