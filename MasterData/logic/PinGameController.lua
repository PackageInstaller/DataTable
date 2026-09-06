-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/controller/PinGameController.lua

module("logic.extensions.pingame.controller.PinGameController", package.seeall)

local PinGameController = class("PinGameController", BaseController)

PinGameController.ReadyGoEvent = "PinGameController_ReadyGo"
PinGameController.StartGameEvent = "PinGameController_StartGame"
PinGameController.ClickExitEvent = "PinGameController_ClickExit"
PinGameController.ClickShootEvent = "PinGameController_ClickShootEvent"
PinGameController.UpdateNeedleLeftNumEvent = "PinGameController_UpdateNeedleLeftNumEvent"
PinGameController.CloseGameView = "PinGameController_CloseGameView"
PinGameController.StopRotateRoot = "PinGameController_StopRotateRoot"
PinGameController.PauseRotateRoot = "PinGameController_PauseRotateRoot"
PinGameController.PlaySuccessTween = "PinGameController_PlaySuccessTween"
PinGameController.CloseEnum_Success = "CloseEnum_Success"
PinGameController.CloseEnum_Fail = "CloseEnum_Fail"
PinGameController.CloseEnum_RuningExit = "CloseEnum_RuningExit"

function PinGameController:onInit()
	return
end

function PinGameController:enterGame(mode, stageId, isLocalGame, activityId)
	local pramsMo = PinGameParamsMo.New(mode, stageId, isLocalGame, activityId)

	self:enterGameByMo(pramsMo)
end

function PinGameController:enterGameByTourArena(mode, stageId, finishCallBack)
	local pramsMo = PinGameParamsMo.New(mode, stageId, true, 0)

	pramsMo:setGameEndCallBack(function(closeEnum)
		if closeEnum == PinGameController.CloseEnum_Success then
			local info = {}

			info.isPass = true
			info.gameScore = 1

			GameUtil.callBack(finishCallBack, info)
		elseif closeEnum == PinGameController.CloseEnum_Fail then
			local info = {}

			info.isPass = true
			info.gameScore = 0

			GameUtil.callBack(finishCallBack, info)
		elseif closeEnum == PinGameController.CloseEnum_RuningExit then
			local info = {}

			info.isPass = false
			info.gameScore = 0

			GameUtil.callBack(finishCallBack, info)
		end
	end)
	self:enterGameByMo(pramsMo)
end

function PinGameController:enterGameByMo(pramsMo)
	UIStateManager.instance:push(ViewName.PinGamePlayView, pramsMo)
end

function PinGameController:isLeftGameTimeToday(activityId)
	local usedTimes = PinGameModel.instance:getTodayGameTimes(activityId)
	local maxTimes = self:getMaxGameTimesToday(activityId)

	return usedTimes < maxTimes
end

function PinGameController:getLeftGameTimesToday(activityId)
	local usedTimes = PinGameModel.instance:getTodayGameTimes(activityId)
	local maxTimes = self:getMaxGameTimesToday(activityId)

	return Mathf.Max(0, maxTimes - usedTimes)
end

function PinGameController:getMaxGameTimesToday(activityId)
	local cfg = PinGameConfig.instance:getActivityCfg(activityId)

	return (cfg or nil) and (cfg.dailyGameTimes or 0)
end

function PinGameController:getGameTimesToday(activityId)
	local usedTimes = PinGameModel.instance:getTodayGameTimes(activityId)
	local maxTimes = self:getMaxGameTimesToday(activityId)

	return Mathf.Max(0, maxTimes - usedTimes), maxTimes
end

function PinGameController:getEncryptedKey(activityId, mode, stageId, isPass)
	local clientKey = PinGameModel.instance:getClientKey(activityId)
	local serverKey = PinGameModel.instance:getServerKey(activityId)

	return GameUtil.getClientEncryptedKey(clientKey, serverKey, {
		mode,
		stageId,
		isPass and 1 or 0
	})
end

function PinGameController:sendPM_PinGameEndGameReq(activityId, mode, stageId, isPass)
	local encryptedKey = self:getEncryptedKey(activityId, mode, stageId, isPass)

	PinGameAgent.instance:sendPM_PinGameEndGameReq(activityId, mode, stageId, isPass, encryptedKey)
end

function PinGameController:enterGameByMoInDomAdvCopy(activityId, blockId, stagePlanId, stageId)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_DomainAdventureActionRes, self._handlePM_DomainAdventureActionRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_DomainAdventureNotifyActionRes, self._handlePM_DomainAdventureNotifyActionRes, self)

	self._stagePlanIdInAdv = stagePlanId
	self._stageIdInAdv = stageId

	local extParams = {}

	extParams.clientKey = math.random(1, 100000)

	local jsonExPrams = GameUtil.jsonToString(extParams)

	DomainAdventureController.instance:sendPM_DomainAdventureActionReq(activityId, blockId, jsonExPrams, nil)
end

function PinGameController:_handlePM_DomainAdventureActionRes(status)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_DomainAdventureActionRes, self._handlePM_DomainAdventureActionRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_DomainAdventureNotifyActionRes, self._handlePM_DomainAdventureNotifyActionRes, self)

	self._stagePlanIdInAdv = 0
	self._stageIdInAdv = 0
end

function PinGameController:_handlePM_DomainAdventureNotifyActionRes(msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_DomainAdventureActionRes, self._handlePM_DomainAdventureActionRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_DomainAdventureNotifyActionRes, self._handlePM_DomainAdventureNotifyActionRes, self)

	local stagePlanId = self._stagePlanIdInAdv
	local stageId = self._stageIdInAdv

	self._stagePlanIdInAdv = 0
	self._stageIdInAdv = 0

	local domAdvParams = {}

	domAdvParams.activityId = msg.actionParam.activityId
	domAdvParams.blockId = msg.actionParam.blockId

	local jsonExtParam = GameUtil.jsonToTable(msg.actionParam.extParam)

	domAdvParams.clientKey = jsonExtParam.clientKey
	domAdvParams.serverKey = jsonExtParam.serverKey

	UIStateManager.instance:push(ViewName.DomAdvCopyPinGamePlayView, stagePlanId, stageId, domAdvParams)
end

PinGameController.instance = PinGameController.New()

return PinGameController
