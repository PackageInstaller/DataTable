-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklybigbox/controller/WeeklyBigBoxController.lua

module("logic.extensions.weeklybigbox.controller.WeeklyBigBoxController", package.seeall)

local WeeklyBigBoxController = class("WeeklyBigBoxController", BaseController)

WeeklyBigBoxController.E_GetInfoRes = "E_GetInfoRes"
WeeklyBigBoxController.E_EndGameRes = "E_EndGameRes"
WeeklyBigBoxController.E_OpenRedPackageRes = "E_OpenRedPackageRes"

function WeeklyBigBoxController:ctor()
	return
end

function WeeklyBigBoxController:onInit()
	return
end

function WeeklyBigBoxController:onReset()
	WeeklyBigBoxModel.instance:onReset()
end

function WeeklyBigBoxController:handleGetInfoRes(status, msg)
	if status == 0 then
		WeeklyBigBoxModel.instance:handleGetInfoRes(msg)
		self:localNotify(WeeklyBigBoxController.E_GetInfoRes)
	end
end

function WeeklyBigBoxController:reqStartGame()
	local model = WeeklyBigBoxModel.instance
	local clientKey = model:beforeStartGame()

	WeeklyBigBoxAgent.instance:sendPM_WeeklyBigBoxStartGameReq(clientKey)
end

function WeeklyBigBoxController:handleStartGameRes(status, msg)
	if status == 0 then
		WeeklyBigBoxModel.instance:handleStartGameRes(msg)
		UIStateManager.instance:push(ViewName.WeeklyBigBoxGameView)
	end
end

function WeeklyBigBoxController:reqEndGame(redPackageNum)
	local model = WeeklyBigBoxModel.instance
	local encryptedKey = model:beforeEndGame(redPackageNum)

	WeeklyBigBoxAgent.instance:sendPM_WeeklyBigBoxEndGameReq(redPackageNum, encryptedKey)
end

function WeeklyBigBoxController:handleEndGameRes(status, msg)
	if status == 0 then
		WeeklyBigBoxModel.instance:handleEndGameRes(msg)
		WeeklyBigBoxAgent.instance:sendPM_WeeklyBigBoxGetInfoReq()
		self:localNotify(WeeklyBigBoxController.E_EndGameRes)
	end
end

function WeeklyBigBoxController:handleOpenRedPackageRes(status, msg)
	if status == 0 then
		WeeklyBigBoxModel.instance:handleOpenRedPackageRes(msg)
		self:localNotify(WeeklyBigBoxController.E_OpenRedPackageRes, msg)
	end
end

WeeklyBigBoxController.instance = WeeklyBigBoxController.New()

return WeeklyBigBoxController
