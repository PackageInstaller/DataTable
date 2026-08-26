-- chunkname: @modules/logic/partygame/controller/PartyGameController.lua

module("modules.logic.partygame.controller.PartyGameController", package.seeall)

local PartyGameController = class("PartyGameController", BaseController)
local partyGameMgrCs = PartyGame.Runtime.GameLogic.GameMgr

function PartyGameController:setUpLuaCallBack()
	partyGameMgrCs.Instance:SetLuaCallBack(self, self.gameStateChange, self.logicTickFinish, self.gamePlayerPush, self.kcpNetStateChange)
	self:SetReconnectLuaCallBack()
end

function PartyGameController:onInit()
	self._curPartyGame = nil
	self._isFirstLogin = true
	self._partyIsEnd = false
end

function PartyGameController:SetReconnectLuaCallBack()
	PartyGame.Runtime.GameLogic.GameInterfaceBase.HotFix_Temp("SetReconnectStateLuaCallBack", self.kcpReconnectState, self)
end

function PartyGameController:onInitFinish()
	return
end

function PartyGameController:addConstEvents()
	self.registerCallback(self, PartyGameEvent.GuidePauseGame, self._onGuidePauseGame, self)
end

function PartyGameController:_onGuidePauseGame(param)
	self:gamePause(tonumber(param) == 1)
end

function PartyGameController:setFirstLogin(isFirst)
	self._isFirstLogin = isFirst
end

function PartyGameController:getFirstLogin()
	return self._isFirstLogin
end

function PartyGameController:reInit()
	self:onInit()
	self:endMatch()
end

function PartyGameController:getCurPartyGame()
	return self._curPartyGame
end

function PartyGameController:enterParty()
	local playerInfo = PlayerModel.instance:getPlayinfo()
	local uid = playerInfo.userId
	local name = playerInfo.name

	PartyGameRpc.instance:sendEnterPartyRequest(uid, name)

	self._isFirstLogin = true
end

function PartyGameController:initFakePlayerData(playerNum, selfCardIds, otherCardIds, teamType)
	local playerInfoStr = self:_getFakePlayerData(playerNum or 8)
	local str = string.format("initFakePlayerData|%s|%s|%s|%s", playerInfoStr, selfCardIds or 0, otherCardIds or 0, teamType or 0)

	PartyGameCSDefine.SnatchAreaInterfaceCs.HotFix_Temp(str, nil, nil)
end

function PartyGameController:_getFakePlayerData(playerNum)
	local mainPlayerName = PlayerModel.instance:getPlayerName() or "mainPlayer"
	local names = PartyGameConfig.instance:getRobotName(playerNum)

	return string.format("%s#%s", mainPlayerName, names)
end

function PartyGameController:enterGame(gameId, isLocal, isTrial)
	if self._curPartyGame ~= nil then
		self:clearGame()
	end

	self._curPartyGame = PartyGameUtils.getGameDefineClass(gameId)

	self._curPartyGame:init(gameId)
	self._curPartyGame:setIsLocal(isLocal)

	if isTrial == nil then
		-- block empty
	end

	self._curPartyGame:setTrial(isTrial)
	self._curPartyGame:setMainPlayerUid()
	self._curPartyGame:enterGame()
end

function PartyGameController:gamePause(pause)
	if self._curPartyGame then
		self._curPartyGame:setGamePause(pause)
	end
end

function PartyGameController:exitGame()
	if self._curPartyGame then
		self._curPartyGame:exitGame()
	end
end

function PartyGameController:exitPartyGame()
	PartyGameModel.instance:setCacheNeedTranGameMsg(nil)
	self:partyGameCloseView()
	PartyGameLobbyController.instance:enterGameLobby()
end

function PartyGameController:partyGameCloseView()
	ViewMgr.instance:closeView(ViewName.MaterialTipView)
	ViewMgr.instance:closeView(ViewName.CardDropVSView)
	ViewMgr.instance:closeView(ViewName.CardDropPromotionView)
end

function PartyGameController:setPartyGameIsEnd(isEnd)
	self._partyIsEnd = isEnd
end

function PartyGameController:getPartyGameIsEnd()
	return self._partyIsEnd
end

function PartyGameController:clearGame()
	if self._isClear then
		logNormal("PartyGameController-clearGame")

		return
	end

	self._isClear = true

	if self._curPartyGame ~= nil then
		self._curPartyGame:onSceneCloseView()
	end

	self._curPartyGame = nil
end

function PartyGameController:gameLoadingFinish()
	if not self._curPartyGame:getIsLocal() then
		PartyGameRpc.instance:sendLoadGameFinishRequest(self._curPartyGame:getGameId())
	end

	self._isClear = false

	self:partyGameCloseView()
end

function PartyGameController:gameStateChange(state)
	self:dispatchEvent(PartyGameEvent.GameStateChange, state)

	if state == PartyGameEnum.GameState.InitFinish then
		logNormal("PartyGameController-init")

		local csGameBase = partyGameMgrCs.Instance.currentGame

		self._curPartyGame:initCsGameBase(csGameBase)
	end

	if state == PartyGameEnum.GameState.GameOver and self._curPartyGame then
		self._curPartyGame:gameOver()
	end

	if state == PartyGameEnum.GameState.GameStart then
		logNormal("--GameStart--")
	end
end

function PartyGameController:logicTickFinish(frame)
	self:dispatchEvent(PartyGameEvent.LogicCalFinish, frame)
end

function PartyGameController:gamePlayerPush(playerList)
	PartyGameModel.instance:initOrUpdateGamePlayer(playerList)
end

function PartyGameController:gameStartPush(data)
	self:dispatchEvent(PartyGameEvent.gameStartPush, data)

	if self._curPartyGame then
		self._curPartyGame:setIsFinish(true)

		if self._curPartyGame then
			self:gamePause(false)
		end
	end

	PartyGameStatHelper.instance:partyGameStart()
end

function PartyGameController:transToGamePush(data)
	if data == nil then
		logNormal("transToGamePush data is nil")

		return
	end

	if self:getPartyGameIsEnd() then
		return
	end

	local gameId = data.GameId

	if isDebugBuild then
		self.rawGameId = gameId
	end

	if self:getIsDebug() and self:getDebugGameId() ~= nil then
		gameId = self:getDebugGameId()
	end

	self:gamePlayerPush(data.Player)
	logNormal("TransToGamePush-->" .. gameId)

	if data.isLocal ~= nil then
		if not data.isLocal then
			local isLocal = false
			local isTrial = false

			if not isLocal then
				isLocal = data.isTrial ~= nil and data.isTrial or false
				isTrial = data.isTrial ~= nil and data.isTrial or false
			end

			self:enterGame(gameId, isLocal, isTrial)
		end
	end
end

function PartyGameController:kcpNetStateChange(state)
	UIBlockMgr.instance:endBlock("kcpReconnect")

	if state then
		logNormal("PartyGameController-kcpNetStateChange connected then login")
		self:Login()
	else
		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.KcpLoginLostConnect, MsgBoxEnum.BoxType.Yes, function()
			self:exitPartyGame()
			PartyGameController.instance:dispatchEvent(PartyGameEvent.KcpConnectFail)
		end, nil)
		PartyGameStatHelper.instance:partyGameReconnect()
	end
end

function PartyGameController:kcpReconnectState(state)
	logNormal("PartyGameController-kcpReconnectState state:" .. tostring(state))
	UIBlockMgrExtend.setNeedCircleMv(true)

	if state then
		UIBlockMgr.instance:startBlock("kcpReconnect")
	else
		UIBlockMgr.instance:endBlock("kcpReconnect")
	end
end

function PartyGameController:kcpLoginCallBack(bytes)
	PartyGameRpc.instance:loginKcpResponse(bytes)
end

function PartyGameController:gmEnterMatch()
	ViewMgr.instance:openView(ViewName.PartyGameMatchView)
end

function PartyGameController:endMatch()
	ViewMgr.instance:closeView(ViewName.PartyGameMatchView)
end

function PartyGameController:getInMatch()
	return ViewMgr.instance:isOpen(ViewName.PartyGameMatchView)
end

function PartyGameController:getIsDebug()
	return self._isDebug or false
end

function PartyGameController:setIsDebug(isDebug)
	self._isDebug = isDebug
end

function PartyGameController:setDebugGameId(gameId)
	self._debugGameId = gameId
end

function PartyGameController:getDebugGameId()
	return self._debugGameId
end

function PartyGameController:openBattleCardReward(data)
	PartyGameModel.instance:updateCurBattleRewardInfo(data)

	local curCardReward = PartyGameModel.instance:getCurBattleRewardInfo()

	if curCardReward:canSelect() then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.PartyGameRewardView, {
			selectCount = curCardReward.selectCount,
			data = curCardReward.cardIds
		})
	end

	PopupController.instance:setPause(PartyGameEnum.PopStopKey, false)
end

function PartyGameController:gameEndResult(data)
	if self._curPartyGame then
		self:dispatchEvent(PartyGameEvent.PartyLittleGameEnd)
		self._curPartyGame:gameEndResult(data)
	end
end

function PartyGameController:setToken(token)
	self._token = token
end

function PartyGameController:getToken()
	return self._token
end

function PartyGameController:Login()
	if self._token == nil then
		logError("PartyGameController-reLogin token is nil")

		return
	end

	PartyGameRpc.instance:loginKcpRequest()
end

function PartyGameController:KcpEndConnect()
	if partyGameMgrCs then
		partyGameMgrCs.Instance:kcpEndConnect()
	end
end

PartyGameController.instance = PartyGameController.New()

return PartyGameController
