-- chunkname: @modules/logic/fight/system/work/FightWorkStepChangeWave.lua

module("modules.logic.fight.system.work.FightWorkStepChangeWave", package.seeall)

local FightWorkStepChangeWave = class("FightWorkStepChangeWave", BaseWork)

function FightWorkStepChangeWave:ctor(nextWaveData)
	self.nextWaveData = nextWaveData
end

function FightWorkStepChangeWave:onStart(context)
	self._flow = FlowSequence.New()

	self._flow:addWork(FightWorkWaveEndDialog.New())
	self._flow:addWork(FightWorkStepShowNoteWhenChangeWave.New())
	self._flow:addWork(WorkWaitSeconds.New(0.01))
	self._flow:addWork(FightWorkChangeWaveView.New())
	self._flow:addWork(FightWorkChangeWaveStartDialog.New())
	self._flow:registerDoneListener(self._startChangeWave, self)
	self._flow:start()
end

function FightWorkStepChangeWave:_startChangeWave()
	FightController.instance:dispatchEvent(FightEvent.ChangeWaveStart)
	FightPlayCardModel.instance:onEndRound()

	self.context.oldEntityIdDict = {}

	local entitys = FightHelper.getAllEntitys()

	for _, entity in ipairs(entitys) do
		entity:resetEntity()

		self.context.oldEntityIdDict[entity.id] = true
	end

	if not self.nextWaveData then
		local fightData = FightDataHelper.cacheFightMgr:getNextFightData()

		if self.nextWaveData then
			self:_changeWave(self.nextWaveData)
		else
			logNormal("还没收到FightWavePush，继续等待")
			FightController.instance:registerCallback(FightEvent.PushFightWave, self._onPushFightWave, self)
		end
	end
end

function FightWorkStepChangeWave:_onPushFightWave()
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, self._onPushFightWave, self)

	if not self.nextWaveData then
		local fightData = FightDataHelper.cacheFightMgr:getNextFightData()

		if self.nextWaveData then
			logNormal("终于等待换波次的信息了")
			self:_changeWave(self.nextWaveData)
			self:onDone(true)
		else
			logError("没有换波次的信息")
			self:onDone(true)
		end
	end
end

function FightWorkStepChangeWave:_changeWave(fightData)
	FightDataHelper.calMgr:playChangeWave()

	self.fightData = fightData

	local fightParam = FightModel.instance:getFightParam()
	local currWaveId = FightModel.instance:getCurWaveId()
	local nextWaveId = currWaveId + 1
	local currLevelId = fightParam:getSceneLevel(currWaveId)
	local nextLevelId = fightParam:getSceneLevel(nextWaveId)

	if nextLevelId and nextLevelId ~= currLevelId then
		self._nextLevelId = nextLevelId

		local fightSpeed = FightModel.instance:getSpeed()

		TaskDispatcher.runDelay(self._delayDone, self, 5)
		TaskDispatcher.runDelay(self._startLoadLevel, self, 0.25 / fightSpeed)
	else
		self:_changeEntity()
		FightController.instance:dispatchEvent(FightEvent.ChangeWaveEnd)
		self:onDone(true)
	end
end

function FightWorkStepChangeWave:_changeEntity()
	logNormal("结束中准备下一波怪")

	local cacheExpoint = self:_cacheExpoint()
	local fightScene = GameSceneMgr.instance:getScene(SceneType.Fight)
	local power = FightModel.instance.power

	FightGameMgr.entityMgr:changeWave(self.fightData)

	FightModel.instance.power = power

	self:_applyExpoint(cacheExpoint)
end

function FightWorkStepChangeWave:_startLoadLevel()
	local work = FightGameMgr.sceneLevelMgr:registWorkLoadLevelWithSwitchEffect(self._nextLevelId)

	work:registFinishCallback(self._onLevelLoaded, self)
	work:start()
end

function FightWorkStepChangeWave:_delayDone()
	self:_changeEntity()
	FightController.instance:dispatchEvent(FightEvent.ChangeWaveEnd)
	self:onDone(true)
end

function FightWorkStepChangeWave:_onLevelLoaded()
	self:_changeEntity()

	local entityList = FightHelper.getAllEntitys()

	for _, entity in ipairs(entityList) do
		entity:resetStandPos()
	end

	FightController.instance:dispatchEvent(FightEvent.ChangeWaveEnd)
	self:onDone(true)
end

function FightWorkStepChangeWave:clearWork()
	if self._flow then
		self._flow:unregisterDoneListener(self._startChangeWave, self)
		self._flow:stop()

		self._flow = nil
	end

	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.cancelTask(self._startLoadLevel, self)
	TaskDispatcher.cancelTask(self._delayCheckNextWaveDialog, self)
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, self._onPushFightWave, self)
end

function FightWorkStepChangeWave:_cacheExpoint()
	local dict = {}
	local all = FightHelper.getAllEntitys()

	for _, entity in ipairs(all) do
		dict[entity.id] = entity:getMO().exPoint
	end

	return dict
end

function FightWorkStepChangeWave:_applyExpoint(dict)
	local all = FightHelper.getAllEntitys()

	for _, entity in ipairs(all) do
		local expoint = dict[entity.id]

		if expoint then
			entity:getMO():setExPoint(expoint)
		end
	end
end

return FightWorkStepChangeWave
