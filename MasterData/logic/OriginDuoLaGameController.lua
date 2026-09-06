-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originduolagame/controller/OriginDuoLaGameController.lua

module("logic.extensions.originduolagame.controller.OriginDuoLaGameController", package.seeall)

local OriginDuoLaGameController = class("OriginDuoLaGameController", BaseController)

function OriginDuoLaGameController:onInit()
	self._curClientKey = nil
	self._curServerKey = nil
	self._isInGame = false
end

function OriginDuoLaGameController:onReset()
	self._curClientKey = nil
	self._curServerKey = nil
	self._isInGame = false

	RedPointController.instance:regMasterServantRed(RedPointModel.ID_ORIGIN_DUOLAGAME, true, RedPointModel.ID_c55, 777)
end

function OriginDuoLaGameController:_getRanamdomClientKey()
	self._curClientKey = MmUtil.createClientKey()

	return self._curClientKey
end

function OriginDuoLaGameController:getClientKey()
	return self._curClientKey
end

function OriginDuoLaGameController:getServerKey()
	return self._curServerKey
end

function OriginDuoLaGameController:getEncryptedKey(stageId, isPass)
	local temPass = isPass and 1 or 0

	return (GameUtil.getClientEncryptedKey(self._curClientKey, self._curServerKey, {
		stageId,
		temPass
	}))
end

function OriginDuoLaGameController:getDefaultActivityId()
	return 597001
end

function OriginDuoLaGameController:getInfo(activityId)
	OriginDuoLaGameAgent.instance:sendPM_OriginDuoLaGameGetInfoReq(activityId)
end

function OriginDuoLaGameController:handlePM_OriginDuoLaGameGetInfoRes(msg)
	OriginDuoLaGameModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDuoLaGameGetInfoRes)
end

function OriginDuoLaGameController:startGame(activityId, stageId)
	local clientKey = self:_getRanamdomClientKey()

	OriginDuoLaGameAgent.instance:sendPM_OriginDuoLaGameStartGameReq(activityId, stageId, clientKey)
end

function OriginDuoLaGameController:handlePM_OriginDuoLaGameStartGameRes(msg)
	self._curServerKey = checknumber(msg.serverKey)
	self._isInGame = true

	OriginDuoLaGameModel.instance:onStartGame(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDuoLaGameStartGameRes)
end

function OriginDuoLaGameController:endGame(activityId, stageId, isPass)
	local encryptedKey = self:getEncryptedKey(stageId, isPass)

	OriginDuoLaGameAgent.instance:sendPM_OriginDuoLaGameEndGameReq(activityId, stageId, isPass, encryptedKey)
end

function OriginDuoLaGameController:handlePM_OriginDuoLaGameEndGameRes(msg)
	OriginDuoLaGameModel.instance:onEndGame(msg)

	self._curClientKey = nil
	self._curServerKey = nil
	self._isInGame = false

	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDuoLaGameEndGameRes)
end

OriginDuoLaGameController.instance = OriginDuoLaGameController.New()

return OriginDuoLaGameController
