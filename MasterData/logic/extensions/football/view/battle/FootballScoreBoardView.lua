-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/battle/FootballScoreBoardView.lua

module("logic.extensions.football.view.battle.FootballScoreBoardView", package.seeall)

local M = class("FootballScoreBoardView", ViewComponent)
local kRoundPattern = "%s/%s"

function M:buildUI()
	self._leftPlayerItem = Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "player"), FootballScoreBoardPlayerItem)
	self._rightPlayerItem = Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "enemy"), FootballScoreBoardPlayerItem)

	self._leftPlayerItem:setTimeoutListener(self._onTimeout, self)

	self._txtRound = goutil.findChildTextComponent(self.mainGO, "bout/txtBout")
	self._timeCountCount = 0
	self._nextPlayerStart = false
end

function M:destroyUI()
	self._leftPlayerItem:destroy()
	self._rightPlayerItem:destroy()

	self._leftPlayerItem = nil
	self._rightPlayerItem = nil
end

function M:onEnter()
	self:_setEvent(true)
	self:_updateView()

	self._timeCountCount = 0
	self._nextPlayerStart = false
end

function M:onExit()
	self:_setEvent(false)
	self._leftPlayerItem:clear()
	self._rightPlayerItem:clear()
end

function M:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnBattleRoundUpdate, self._onUpdateBattleRound, self)
		BattleDispatcher:addEventListener(BattleEventType.OnPlayerStarted, self._onPlayerStarted, self)
		BattleDispatcher:addEventListener(BattleEventType.OnEntityStepped, self._onEntityStepped, self)
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_NEXT_OPERATE, self._onReceiveNextOperate, self)
		GlobalDispatcher:addEventListener(EventType.FOOTBALL_SCORE_UPDATE, self._onScoreUpdate, self)
		GlobalDispatcher:addEventListener(EventType.FOOTBALL_MANNUAL_ATTACK, self._onManualAttack, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleRoundUpdate, self._onUpdateBattleRound, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnPlayerStarted, self._onPlayerStarted, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnEntityStepped, self._onEntityStepped, self)
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_NEXT_OPERATE, self._onReceiveNextOperate, self)
		GlobalDispatcher:removeEventListener(EventType.FOOTBALL_SCORE_UPDATE, self._onScoreUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.FOOTBALL_MANNUAL_ATTACK, self._onManualAttack, self)
	end
end

function M:_updateView()
	local battleModel = BattleMgr.instance:getModel()

	self._txtRound.text = string.format(kRoundPattern, battleModel:getCurrentRound(), battleModel:getMaxRound())

	local operateTeamId = battleModel:getOperateGameTeamId()
	local settingModel = BattleMgr.instance:getSettingModel()
	local teamInfoMOList = settingModel:getTeamInfoMOList()

	for _, teamInfoMO in ipairs(teamInfoMOList) do
		if operateTeamId == teamInfoMO.teamId then
			self._leftPlayerItem:setUserInfoMO(teamInfoMO:getLeaderUserInfoMO())
		else
			self._rightPlayerItem:setUserInfoMO(teamInfoMO:getLeaderUserInfoMO())
		end
	end
end

function M:_onUpdateBattleRound(e, currentRound, maxRound)
	self._txtRound.text = string.format(kRoundPattern, currentRound, maxRound)
end

function M:_onEntityStepped(e, entityId)
	self._leftPlayerItem:stopCountDown()
	self._rightPlayerItem:stopCountDown()
end

function M:_onPlayerStarted(e, campId)
	self._nextPlayerStart = campId
end

function M:_onReceiveNextOperate()
	if not self._nextPlayerStart then
		return
	end

	local campId = self._nextPlayerStart
	local battleModel = BattleMgr.instance:getModel()
	local campInfo = battleModel:getCampInfo(campId)

	if campInfo.gameTeamId == self._leftPlayerItem:getTeamId() then
		local timeLimit = FootBallConfig.instance:getConstNum(FootBallConstEnum.OperateTimeLimit)

		self._leftPlayerItem:startCountDown(timeLimit)
		self._rightPlayerItem:stopCountDown()
	elseif campInfo.gameTeamId == self._rightPlayerItem:getTeamId() then
		local timeLimit = FootBallConfig.instance:getConstNum(FootBallConstEnum.OperateTimeLimit)

		self._leftPlayerItem:stopCountDown()
		self._rightPlayerItem:startCountDown(timeLimit)
	elseif enableErrorLog then
		printError("unhandle campId", campId)
	end

	self._nextPlayerStart = false
end

function M:_onScoreUpdate(e)
	local leftScore = FootballModel.instance:getTeamScore(self._leftPlayerItem:getTeamId())

	self._leftPlayerItem:setScore(leftScore)

	local rightScore = FootballModel.instance:getTeamScore(self._rightPlayerItem:getTeamId())

	self._rightPlayerItem:setScore(rightScore)
end

function M:_onTimeout(playerItem)
	local battleModel = BattleMgr.instance:getModel()
	local operateUserId = battleModel:getOperateUserId()

	if operateUserId ~= playerItem:getUserId() then
		return
	end

	self._timeCountCount = self._timeCountCount + 1

	ViewMgr.instance:close(ViewName.FootballQTE)

	if self._timeCountCount < FootBallConfig.instance:getConstNum(FootBallConstEnum.ChangeToAutoTimeoutCount) then
		BattleDispatcher:dispatchEvent(BattleEventType.OnForceOperate)

		return
	end

	BattleDispatcher:dispatchEvent(BattleEventType.ON_SET_AUTO_MODE, true)
end

function M:_onManualAttack()
	self._timeCountCount = 0
end

return M
