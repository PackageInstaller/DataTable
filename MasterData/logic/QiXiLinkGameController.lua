-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qixilinkgame/controller/QiXiLinkGameController.lua

module("logic.extensions.qixilinkgame.controller.QiXiLinkGameController", package.seeall)

local QiXiLinkGameController = class("QiXiLinkGameController", BaseController)

function QiXiLinkGameController:onReset()
	self._lastGameIds = -1
end

function QiXiLinkGameController:sendPM_LinkendlessGameInfoReq(activityId)
	QiXiLinkGameAgent.instance:sendPM_LinkendlessGameInfoReq(activityId)
end

function QiXiLinkGameController:handlePM_LinkendlessGameInfoRes(msg)
	QiXiLinkGameModel.instance:handlePM_LinkendlessGameInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LinkendlessGameInfoRes)
end

function QiXiLinkGameController:sendPM_LinkendlessGameStartGameReq(activityId)
	local clientKey = QiXiLinkGameModel.instance:getClientKey(activityId)

	QiXiLinkGameAgent.instance:sendPM_LinkendlessGameStartGameReq(activityId, clientKey)
end

function QiXiLinkGameController:handlePM_LinkendlessGameStartGameRes(msg)
	QiXiLinkGameModel.instance:handlePM_LinkendlessGameStartGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LinkendlessGameStartGameRes)
end

function QiXiLinkGameController:sendPM_LinkendlessGameEndGameReq(activityId, score)
	local encryptedKey = QiXiLinkGameModel.instance:getEncryptedKey(activityId, score)

	QiXiLinkGameAgent.instance:sendPM_LinkendlessGameEndGameReq(activityId, score, encryptedKey)
end

function QiXiLinkGameController:handlePM_LinkendlessGameEndGameRes(msg)
	QiXiLinkGameModel.instance:handlePM_LinkendlessGameEndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LinkendlessGameEndGameRes)
end

function QiXiLinkGameController:sendPM_LinkendlessGameSweepReq(activityId, times)
	QiXiLinkGameAgent.instance:sendPM_LinkendlessGameSweepReq(activityId, times)
end

function QiXiLinkGameController:handlePM_LinkendlessGameSweepRes(msg)
	QiXiLinkGameModel.instance:handlePM_LinkendlessGameSweepRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LinkendlessGameSweepRes)
end

function QiXiLinkGameController:sendPM_LinkendlessGameGainProgressPrizeReq(activityId, prizeId)
	QiXiLinkGameAgent.instance:sendPM_LinkendlessGameGainProgressPrizeReq(activityId, prizeId)
end

function QiXiLinkGameController:handlePM_LinkendlessGameGainProgressPrizeRes(msg)
	QiXiLinkGameModel.instance:handlePM_LinkendlessGameGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LinkendlessGameGainProgressPrizeRes)
end

function QiXiLinkGameController:getTheGameId()
	local curGameId = math.random(1, 20)

	if curGameId == self._lastGameIds then
		curGameId = curGameId + 1 < 20 and curGameId + 1 or curGameId - 1
	end

	self._lastGameIds = curGameId

	return curGameId
end

QiXiLinkGameController.instance = QiXiLinkGameController.New()

return QiXiLinkGameController
