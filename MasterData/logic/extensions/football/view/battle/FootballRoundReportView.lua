-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/battle/FootballRoundReportView.lua

module("logic.extensions.football.view.battle.FootballRoundReportView", package.seeall)

local M = class("FootballRoundReportView", ViewComponent)
local kReportType = {
	ROUND_BEGIN = 6,
	END = 2,
	OPERATE_CAMP_BEGIN = 3,
	SCORE_UPDATE = 5,
	OTHER_CAMP_BEGIN = 4,
	START = 1
}
local kZhNum = {
	"一",
	"二",
	"三",
	"四",
	"五",
	"六",
	"七",
	"八",
	"九",
	"十"
}
local kDuration = 2

function M:buildUI()
	self._goReportRootList = {}
	self._goReportRootList[kReportType.START] = goutil.findChild(self.mainGO, "startHint")
	self._goReportRootList[kReportType.END] = goutil.findChild(self.mainGO, "endHint")
	self._goReportRootList[kReportType.OPERATE_CAMP_BEGIN] = goutil.findChild(self.mainGO, "playerBout")
	self._goReportRootList[kReportType.OTHER_CAMP_BEGIN] = goutil.findChild(self.mainGO, "enemyBout")
	self._goReportRootList[kReportType.SCORE_UPDATE] = goutil.findChild(self.mainGO, "scoreShow")
	self._goReportRootList[kReportType.ROUND_BEGIN] = goutil.findChild(self.mainGO, "boutHint")
	self._animationReportRootList = {}

	for _, go in pairs(self._goReportRootList) do
		goutil.setActive(go, true)
		table.insert(self._animationReportRootList, goutil.addComponentOnce(go, ComponentType.Animation))
	end

	self._txtRound = goutil.findChildTextComponent(self.mainGO, "boutHint/bout")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "scoreShow/txtScore")
	self._leftPlayerItem = Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "playerBout"), FootballRoundReportPlayerItem)
	self._rightPlayerItem = Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "enemyBout"), FootballRoundReportPlayerItem)
	self._handler = Handler.New()
	self._timerWaiter = false
	self._autoUnlockOperation = false
end

function M:destroyUI()
	self._leftPlayerItem:destroy()
	self._rightPlayerItem:destroy()

	self._leftPlayerItem = nil
	self._rightPlayerItem = nil
	self._goReportRootList = nil
	self._animationReportRootList = nil
	self._txtRound = nil
	self._txtScore = nil
end

function M:onEnter()
	self:_setEvent(true)
	self:_onBattleSpeedUpdate()
	self:_updateView()
	goutil.setActive(self.mainGO, false)
	FootBallReportViewFacade.instance:registerView(self)
end

function M:onExit()
	self:_setEvent(false)
	self:_clearTimeWaiter()
	self._handler:clear()
	FootBallReportViewFacade.instance:unregisterView()
end

function M:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnBattleSpeedUpdate, self._onBattleSpeedUpdate, self)
		BattleDispatcher:addEventListener(BattleEventType.OnBattleRoundUpdate, self._onUpdateBattleRound, self)
		GlobalDispatcher:addEventListener(EventType.FOOTBALL_SCORE_UPDATE, self._onScoreUpdate, self)
		GlobalDispatcher:addEventListener(EventType.FOOTBALL_FIRST_ATTACK_STAGE_UPDATE, self._onFirstAttackStageUpdate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleSpeedUpdate, self._onBattleSpeedUpdate, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleRoundUpdate, self._onUpdateBattleRound, self)
		GlobalDispatcher:removeEventListener(EventType.FOOTBALL_SCORE_UPDATE, self._onScoreUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.FOOTBALL_FIRST_ATTACK_STAGE_UPDATE, self._onFirstAttackStageUpdate, self)
	end
end

function M:playStartReport(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self:_playReport(kReportType.START, false)
end

function M:playEndReport(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self:_playReport(kReportType.END, true)
end

function M:playOperateCampStartReport(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self:_playReport(kReportType.OPERATE_CAMP_BEGIN, true)
end

function M:playOtherCampStartReport(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self:_playReport(kReportType.OTHER_CAMP_BEGIN, true)
end

function M:playScoreReport(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self:_playReport(kReportType.SCORE_UPDATE, true)
end

function M:playRoundStartReport(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self:_playReport(kReportType.ROUND_BEGIN, true)
end

function M:_updateView()
	local battleModel = BattleMgr.instance:getModel()
	local settingModel = BattleMgr.instance:getSettingModel()
	local operateTeamId = battleModel:getOperateGameTeamId()
	local teamInfoMOList = settingModel:getTeamInfoMOList()

	for _, teamInfoMO in ipairs(teamInfoMOList) do
		if operateTeamId == teamInfoMO.teamId then
			self._leftPlayerItem:setUserInfoMO(teamInfoMO:getLeaderUserInfoMO())
		else
			self._rightPlayerItem:setUserInfoMO(teamInfoMO:getLeaderUserInfoMO())
		end
	end
end

function M:_playReport(targetReportType, autoUnlockOperation)
	self._autoUnlockOperation = autoUnlockOperation
	self._timerWaiter = self:_getTimeWaiter()

	for reportType, go in pairs(self._goReportRootList) do
		if reportType == targetReportType then
			goutil.setActive(self.mainGO, true)
			goutil.setActive(go, true)
			self._timerWaiter:start(kDuration, self._onReportFinish, self)
			self._timerWaiter:setTimeScale(BattleTime.timeScale)
		else
			goutil.setActive(go, false)
		end
	end

	BattleMainViewFacade.instance:lockOperation()
end

function M:_onReportFinish()
	goutil.setActive(self.mainGO, false)
	self:_clearTimeWaiter()
	self._handler:callAndClear()

	if self._autoUnlockOperation then
		BattleMainViewFacade.instance:unlockOperation()
	end
end

function M:_onBattleSpeedUpdate()
	for _, animation in pairs(self._animationReportRootList) do
		AnimationUtils.SetPlaySpeed(animation, BattleTime.timeScale)
	end
end

function M:_onUpdateBattleRound(e, currentRound, maxRound)
	self._txtRound.text = string.format("第%s回合", kZhNum[currentRound])
end

function M:_onScoreUpdate(e)
	local leftScore = FootballModel.instance:getTeamScore(self._leftPlayerItem:getTeamId())
	local rightScore = FootballModel.instance:getTeamScore(self._rightPlayerItem:getTeamId())

	self._txtScore.text = string.format("<color=#F15A24>%s</color> : %s", leftScore, rightScore)
end

function M:_onFirstAttackStageUpdate(e, stageId)
	local battleModel = BattleMgr.instance:getModel()
	local leftCampInfo = battleModel:getCampInfoByUserId(self._leftPlayerItem:getUserId())

	if leftCampInfo and leftCampInfo.stageId == stageId then
		self._leftPlayerItem:setPriorityCounter(true)
		self._rightPlayerItem:setPriorityCounter(false)
	else
		self._leftPlayerItem:setPriorityCounter(false)
		self._rightPlayerItem:setPriorityCounter(true)
	end
end

function M:_getTimeWaiter()
	if self._timerWaiter then
		self._timerWaiter:clear()

		return self._timerWaiter
	end

	return TimeWaiter:createInstance()
end

function M:_clearTimeWaiter()
	if self._timerWaiter then
		self._timerWaiter:returnSelf()

		self._timerWaiter = false
	end
end

return M
