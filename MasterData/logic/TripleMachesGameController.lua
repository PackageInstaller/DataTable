-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/controller/TripleMachesGameController.lua

module("logic.extensions.triplemacthesgame.controller.TripleMachesGameController", package.seeall)

local TripleMachesGameController = class("TripleMachesGameController", BaseController)

function TripleMachesGameController:ctor()
	return
end

function TripleMachesGameController:onInit()
	self._stateFsm = SxGameStateFSM.New()

	self._stateFsm:onInit()
	self:onReset()
end

function TripleMachesGameController:onReset()
	self.sxGameInfo = nil
end

function TripleMachesGameController:initMapData()
	return
end

function TripleMachesGameController:add2Queue()
	self._stateFsm:swicthState("TripleMacthesAdd2Queue")
end

function TripleMachesGameController:findScore()
	self._stateFsm:swicthState("TripleMacthesFindScore")
end

function TripleMachesGameController:scoreAction()
	self._stateFsm:swicthState("TripleMacthesScoreAction")
end

function TripleMachesGameController:viewSwap()
	self._stateFsm:swicthState("TripleMacthesViewSwap")
end

function TripleMachesGameController:viewSwapBack()
	self._stateFsm:swicthState("TripleMacthesViewSwapBack")
end

function TripleMachesGameController:continueFindScore()
	self._stateFsm:swicthState("TripleMacthesContinueFindScore")
end

function TripleMachesGameController:defaultState()
	self._stateFsm:swicthState("TripleMacthesDefaultState")
end

function TripleMachesGameController:specialState(...)
	self._stateFsm:swicthState("TripleMacthesSpecialState")
end

function TripleMachesGameController:addAction(actionData)
	GlobalDispatcher:dispatch(GlobalNotify.ThreeMathesTryDoAction)

	if (self._stateFsm:getCurStateName() == "TripleMacthesAdd2Queue" or self._stateFsm:getCurStateName() == "TripleMacthesDefaultState") and not TripleMacthesGameModel.instance:isWaitingMoveRes() then
		local secuss = TripleMacthesGameModel.instance:addAction(actionData)

		if secuss then
			self:add2Queue()
		end

		return secuss
	end

	return false
end

function TripleMachesGameController:addActionByGuest(x, y)
	GlobalDispatcher:dispatch(GlobalNotify.ThreeMathesTryDoAction)

	if (self._stateFsm:getCurStateName() == "TripleMacthesAdd2Queue" or self._stateFsm:getCurStateName() == "TripleMacthesDefaultState") and not TripleMacthesGameModel.instance:isWaitingMoveRes() then
		local secuss = TripleMacthesGameModel.instance:addActionByGuest(x, y)

		if secuss then
			self:add2Queue()
		end

		return secuss
	end

	return false
end

function TripleMachesGameController:getCurrStateName()
	return self._stateFsm:getCurStateName()
end

function TripleMachesGameController:playNormalEffect()
	return
end

function TripleMachesGameController:playSpecialEffect()
	return
end

function TripleMachesGameController:isCanDoAction()
	if self._stateFsm:getCurStateName() == "TripleMacthesAdd2Queue" or self._stateFsm:getCurStateName() == "TripleMacthesDefaultState" then
		return true
	end

	return false
end

function TripleMachesGameController:changeAllEmptyShow(isReverse)
	TripleMacthesGameModel.instance:changeAllEmptyShow(isReverse)
end

function TripleMachesGameController:handlePM_TripleMatchesGameGetInfoRes(msg)
	TripleMacthesModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_TripleMatchesGameGetInfoRes)
end

function TripleMachesGameController:sendPM_TripleMatchesGameStartGameReq(activityId)
	local clientKey = TripleMacthesGameModel.instance:randomClientKey()

	TripleMatchesGameAgent.instance:sendPM_TripleMatchesGameStartGameReq(activityId, clientKey)
end

function TripleMachesGameController:handlePM_TripleMatchesGameStartGameRes(msg)
	TripleMacthesGameModel.instance:setServerKey(msg.serverKey)
	TripleMacthesGameModel.instance:getMapInfo(msg.activityId, msg.stageId)
	TripleMacthesGameModel.instance:initGameMapArrFromMsg(msg.activityId)
	TripleMacthesModel.instance:initGameInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TripleMacthesGameStart)
end

function TripleMachesGameController:sendPM_TripleMatchesGameEndGameReq(activityId, stageId, score, save)
	local tb = {
		stageId,
		score,
		save == true and 1 or 0
	}
	local encryptedKey = 0
	local clientKey = TripleMacthesGameModel.instance:getClientKey()
	local serverKey = GenEncryptedKeyUtil.dxor(TripleMacthesGameModel.instance:getServerKey(), clientKey)

	for i, num in ipairs(tb) do
		encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
	end

	TripleMatchesGameAgent.instance:sendPM_TripleMatchesGameEndGameReq(activityId, stageId, score, save, encryptedKey)
end

function TripleMachesGameController:handlePM_TripleMatchesGameEndGameRes(msg)
	TripleMacthesModel.instance:saveGameInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TripleMacthesGameEnd)
end

function TripleMachesGameController:handlePM_TripleMatchesGameBuyStepRes(msg)
	TripleMacthesModel.instance:saveBuyStep(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TripleMacthesGameBuyStep)
end

function TripleMachesGameController:handlePM_TripleMatchesGameRankViewRes(msg)
	TripleMacthesModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TripleMacthesRankRefresh)
end

function TripleMachesGameController:sendPM_TripleMatchesGameSweepReq(activityId, times)
	TripleMatchesGameAgent.instance:sendPM_TripleMatchesGameSweepReq(activityId, times)
end

function TripleMachesGameController:handlePM_TripleMatchesGameSweepRes(msg)
	TripleMacthesModel.instance:handlePM_TripleMatchesGameSweepRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TripleMatchesGameSweepRes)
end

function TripleMachesGameController:tourArenaStartGame(activityId, stageId)
	TripleMacthesGameModel.instance:initGameMapArrFromTourArena(activityId, stageId)
	TripleMacthesModel.instance:initGameCfgByTourArena(activityId, stageId)
	GlobalDispatcher:dispatch(GlobalNotify.TripleMacthesGameStart)
end

TripleMachesGameController.instance = TripleMachesGameController.New()

return TripleMachesGameController
