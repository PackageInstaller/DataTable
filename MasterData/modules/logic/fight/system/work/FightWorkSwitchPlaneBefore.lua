-- chunkname: @modules/logic/fight/system/work/FightWorkSwitchPlaneBefore.lua

module("modules.logic.fight.system.work.FightWorkSwitchPlaneBefore", package.seeall)

local FightWorkSwitchPlaneBefore = class("FightWorkSwitchPlaneBefore", FightWorkItem)

function FightWorkSwitchPlaneBefore:onStart()
	self.work = self:com_registWork(FightWorkClearBeforeSwitchPlane)

	self.work:registFinishCallback(self._onWorkFinish, self)
	self:cancelFightWorkSafeTimer()
	self.work:start()
end

function FightWorkSwitchPlaneBefore:_onWorkFinish()
	local prevSceneLevelId = GameSceneMgr.instance:getCurLevelId()
	local fightParam = FightModel.instance:getFightParam()
	local firstLevelId = fightParam:getSceneLevel(1)

	if prevSceneLevelId ~= firstLevelId then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView)
		GameSceneMgr.instance:showLoading(SceneType.Fight)
		TaskDispatcher.runDelay(self._delayDone, self, 5)
		TaskDispatcher.runDelay(self._startLoadLevel, self, 0.25)

		self._loadTime = Time.time
	else
		self:onDone(true)
	end
end

function FightWorkSwitchPlaneBefore:_startLoadLevel()
	FightController.instance:registerCallback(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded, self)

	local fightScene = GameSceneMgr.instance:getScene(SceneType.Fight)
	local fightParam = FightModel.instance:getFightParam()
	local firstLevelId = fightParam:getSceneLevel(1)

	FightGameMgr.sceneLevelMgr:loadScene(nil, firstLevelId)
end

function FightWorkSwitchPlaneBefore:_onLevelLoaded()
	local passTime = Time.time - self._loadTime
	local delay = 0.5 - passTime

	if delay <= 0 then
		self:onDone(true)
	else
		TaskDispatcher.cancelTask(self._delayDone, self)
		TaskDispatcher.runDelay(self._delayDone, self, delay)
	end

	GameSceneMgr.instance:getCurScene().camera:setSceneCameraOffset()
end

function FightWorkSwitchPlaneBefore:_delayDone()
	self:onDone(true)
end

function FightWorkSwitchPlaneBefore:clearWork()
	GameSceneMgr.instance:hideLoading()
	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.cancelTask(self._startLoadLevel, self)
	FightController.instance:unregisterCallback(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded, self)

	if self.work then
		self.work:disposeSelf()

		self.work = nil
	end
end

return FightWorkSwitchPlaneBefore
