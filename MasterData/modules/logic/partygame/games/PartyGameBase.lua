-- chunkname: @modules/logic/partygame/games/PartyGameBase.lua

module("modules.logic.partygame.games.PartyGameBase", package.seeall)

local PartyGameBase = class("PartyGameBase")

function PartyGameBase:ctor()
	self._gameId = -1
	self._gameConfigId = -1
	self._gameTime = 0
	self._csGameBase = nil
	self._initFinish = false
	self._isLocal = false
	self._isTrial = false
	self._isTeamType = false
	self._mainPlayerUid = -1
	self.gameStartTime = 0
end

function PartyGameBase:init(gameId, gameConfigId)
	self._gameId = gameId
	self._gameConfigId = gameConfigId
	self._gameParamCo = lua_partygame_param.configDict[self._gameId]

	if self._gameParamCo then
		self._gameTime = self._gameParamCo.gameTime
	end

	self.gameStartTime = Time.realtimeSinceStartup
end

function PartyGameBase:canEndLoading()
	local interval = Time.realtimeSinceStartup - self.gameStartTime

	return interval >= PartyGameEnum.LoadingTime
end

function PartyGameBase:setIsLocal(isLocal)
	if isLocal == nil then
		return
	end

	self._isLocal = isLocal
end

function PartyGameBase:getIsLocal()
	return self._isLocal
end

function PartyGameBase:setTrial(isTrial)
	if isTrial == nil then
		return
	end

	self._isTrial = isTrial
end

function PartyGameBase:getIsTrial()
	return self._isTrial
end

function PartyGameBase:getGameId()
	return self._gameId
end

function PartyGameBase:isTeamType()
	return self._isTeamType
end

function PartyGameBase:initCsGameBase(csGameBase)
	if self._csGameBase ~= nil then
		return
	end

	self._csGameBase = csGameBase

	local needPause = true

	if self._needPause ~= nil then
		needPause = self._needPause
		self._needPause = nil
	end

	self._isTeamType = PartyGameModel.instance:getCurGameIsTeamType()

	self:setIsFinish(true)
	self:setGamePause(needPause)
end

function PartyGameBase:setMainPlayerUid()
	local playerInfo = PlayerModel.instance:getPlayinfo()
	local uid = playerInfo.userId

	self._mainPlayerUid = tonumber(uid)

	logNormal("设置MainPlayerUid" .. uid)
end

function PartyGameBase:getMainPlayerUid()
	if self._isLocal then
		local allPlayer = PartyGameModel.instance:getCurGamePlayerList()

		for i = 1, #allPlayer do
			local player = allPlayer[i]

			if player.isRobot == 0 then
				return player.uid
			end
		end
	end

	return self._mainPlayerUid
end

function PartyGameBase:setIsFinish(isFinish)
	if self._csGameBase == nil then
		return
	end

	self._initFinish = isFinish
end

function PartyGameBase:isInitFinish()
	return self._initFinish
end

function PartyGameBase:isCanControl()
	if self._csGameBase == nil then
		return false
	end

	return self._csGameBase:CanControl()
end

function PartyGameBase:setGamePause(isPause)
	if self._csGameBase == nil then
		self._needPause = isPause

		return
	end

	if isPause then
		self._csGameBase:PauseGame()
	else
		self._csGameBase:ResumeGame()
	end
end

function PartyGameBase:enterGame()
	if self._gameId == PartyGameEnum.GameId.CardDrop then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.PartyGameCardDropLoadingView)
	else
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.PartyGameLobbyLoadingView)
	end

	GameSceneMgr.instance:startScene(SceneType.PartyGame, 280001, 280001, true, true)
end

function PartyGameBase:gameOver()
	if self._isLocal then
		return
	end
end

function PartyGameBase:exitGame()
	self._csGameBase = nil

	logNormal("PartyGameBase-exitGame")

	local msg = PartyGameModel.instance:getCacheNeedTranGameMsg()

	if msg ~= nil then
		PartyGameController.instance:transToGamePush(msg)
		PartyGameModel.instance:setCacheNeedTranGameMsg(nil)
	else
		PartyGameLobbyController.instance:enterGameLobby()
	end
end

function PartyGameBase:gameEndResult(data)
	if not self._isLocal or self._isTrial then
		PopupController.instance:setPause(PartyGameEnum.PopStopKey, true)
	end

	PartyGameController.instance:dispatchEvent(PartyGameEvent.OnGameEnd)
	PartyGameStatHelper.instance:partyGameEnd()
end

function PartyGameBase:onScenePrepared()
	local viewName = self:getGameViewName()

	if not string.nilorempty(viewName) then
		ViewMgr.instance:openView(viewName)
	end

	HelpController.instance:registerCallback(HelpEvent.OnClickHelpViewMask, self.closeHelpView, self)
	self:setHelpViewBlur(nil)

	local isShow = TimeUtil.getDayFirstLoginRed("PartyGame_HelpView")

	if isShow then
		local co = self:getGameConfig()
		local helpId = co and co.helpId

		if helpId and helpId > 0 then
			HelpController.instance:showHelp(helpId)
			ViewMgr.instance:openView(ViewName.PartyGameHelpView)
		end
	end
end

function PartyGameBase:setHelpViewBlur(bgBlur)
	local setting = ViewMgr.instance:getSetting(ViewName.HelpView)

	if not setting then
		return
	end

	setting.bgBlur = bgBlur
end

function PartyGameBase:closeHelpView()
	ViewMgr.instance:closeView(ViewName.HelpView)
end

function PartyGameBase:onSceneClose()
	local viewName = self:getGameViewName()

	if not string.nilorempty(viewName) then
		ViewMgr.instance:closeView(viewName)
	end
end

function PartyGameBase:getGameViewName()
	return
end

function PartyGameBase:onSceneCloseView()
	HelpController.instance:unregisterCallback(HelpEvent.OnClickHelpViewMask, self.closeHelpView, self)
	self:setHelpViewBlur(1)
	ViewMgr.instance:closeView(ViewName.HelpView)
	ViewMgr.instance:closeView(ViewName.PartyGameHelpView)
	self:onSceneClose()
	ViewMgr.instance:closeView(ViewName.PartyGameResultView)
	ViewMgr.instance:closeView(ViewName.PartyGameRewardView)
	ViewMgr.instance:closeView(ViewName.PartyGameRewardGuideView)
	ViewMgr.instance:closeView(ViewName.PartyGameSoloResultView)
	ViewMgr.instance:closeView(ViewName.PartyGameSoloResultGuideView)
	ViewMgr.instance:closeView(ViewName.PartyGameTeamResultView)
	ViewMgr.instance:closeView(ViewName.PartyGameTeamResultGuideView)
end

function PartyGameBase:getGameConfig()
	return self._gameParamCo
end

function PartyGameBase:getCameraConfigId()
	return (self._gameParamCo or nil) and (self._gameParamCo.camera or 1)
end

function PartyGameBase:getCameraFocus()
	local arr = {}

	if self._gameParamCo and not string.nilorempty(self._gameParamCo.focus) then
		arr = string.splitToNumber(self._gameParamCo.focus, "#")
	end

	return arr[1] or 0, arr[2] or 0, arr[3] or 0
end

function PartyGameBase:getPlayerScore(uid)
	if self._csGameBase == nil then
		return 0
	end

	return self._csGameBase:GetPlayerScore(uid)
end

function PartyGameBase:getPlayerTeamScore(teamType)
	if not self._isTeamType or self._csGameBase == nil then
		return 0
	end

	local total = 0
	local allPlayer = PartyGameModel.instance:getCurGamePlayerList()

	for _, v in ipairs(allPlayer) do
		if v.tempType == teamType then
			local score = self:getPlayerScore(v.uid)

			if type(score) == "number" then
				total = total + score
			end
		end
	end

	return total
end

function PartyGameBase:getRank(uid)
	if self._csGameBase == nil then
		return 0
	end

	return self._csGameBase:GetPlayerRank(uid)
end

function PartyGameBase:getWinTeam()
	if self._csGameBase == nil then
		return 0
	end

	return self._csGameBase:GetWinTeam()
end

function PartyGameBase:getGameBase()
	return self._csGameBase
end

function PartyGameBase:getConnectNet()
	if not self._csGameBase then
		return
	end

	return self._csGameBase.connectNet
end

function PartyGameBase:isGuiding()
	local result = PartyGameCSDefine.CardDropInterfaceCs.HotFix_Temp("curGameIsGuiding", nil, nil)

	return result == "1"
end

function PartyGameBase:getGameFov()
	return
end

return PartyGameBase
