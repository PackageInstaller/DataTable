-- chunkname: @modules/logic/fight/system/work/FightWorkPlayStart.lua

module("modules.logic.fight.system.work.FightWorkPlayStart", package.seeall)

local FightWorkPlayStart = class("FightWorkPlayStart", FightWorkItem)

function FightWorkPlayStart:onStart()
	FightGameMgr.checkCrashMgr:startCheck()

	if FightDataHelper.stateMgr.isReplay then
		FightReplayController.instance._replayErrorFix:startReplayErrorFix()
	end

	self.roundData = FightDataHelper.roundMgr:getRoundData()

	local flow = self:com_registFlowSequence()

	flow:addWork(FightGameMgr.necessaryAssetLoaderMgr:registWorkLoadAsset())
	flow:registWork(FightWorkFunction, FightDataHelper.stateMgr.setMark, FightDataHelper.stateMgr, FightStateDataMgr.Mark.NewAllEntityWhenEnter)
	flow:addWork(FightGameMgr.entityMgr:registNewAllEntityWork())
	flow:registWork(FightWorkFunction, FightDataHelper.stateMgr.clearMark, FightDataHelper.stateMgr, FightStateDataMgr.Mark.NewAllEntityWhenEnter)

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		-- block empty
	else
		flow:registWork(FightWorkFunction, ViewMgr.instance.openView, ViewMgr.instance, ViewName.FightSkillSelectView)
		flow:registWork(FightWorkFunction, ViewMgr.instance.openView, ViewMgr.instance, ViewName.FightView)
	end

	flow:registWork(FightWorkSendEvent, FightEvent.OnStartSequenceStart)
	flow:addWork(FightWorkDialogBeforeStartFight.New())
	flow:addWork(FightWorkAppearPerformance.New())
	flow:addWork(FightWorkDetectReplayEnterSceneActive.New())
	flow:addWork(FightWorkShowTowerComposeSwitchPlane.New())

	FightStartSequence.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWave, 1)

	local focusEntityId = FightWorkFocusMonster.getFocusEntityId()

	if focusEntityId or FightStartSequence.needStopMonsterWave then
		self:_buildFocusBorn(flow)
	else
		self:_buildNormalBorn(flow)
	end

	flow:addWork(FightWorkCompareDataAfterPlay.New())
	flow:addWork(FightWorkFbStory.New(FightWorkFbStory.Type_EnterWave))
	flow:addWork(FunctionWork.New(function()
		local roundData = FightDataHelper.roundMgr:getRoundData()

		FightDataMgr.instance:afterPlayRoundData(roundData)
	end))
	flow:addWork(FunctionWork.New(function()
		FightRpc.instance:dealCardInfoPushData()
	end))
	flow:addWork(FunctionWork.New(function()
		FightViewPartVisible.set(true, true, true, false, false)
	end))
	flow:registFinishCallback(self.onFlowFinish, self)
	self:playWorkAndDone(flow, {})
end

function FightWorkPlayStart:onFlowFinish()
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.Enter)
	FightController.instance:dispatchEvent(FightEvent.OnStartSequenceFinish)
end

function FightWorkPlayStart:_buildFocusBorn(flow)
	if FightStartSequence.needStopMonsterWave then
		flow:addWork(FunctionWork.New(function()
			self:_setMonsterVisible(false)
		end))
	end

	flow:addWork(FightWorkStartBorn.New())

	if FightStartSequence.needStopMonsterWave then
		flow:addWork(FightWorkWaitDialog.New(1))
		flow:addWork(FunctionWork.New(function()
			self:_setMonsterVisible(true)
		end))
	end

	flow:addWork(FightWorkFocusMonster.New())

	local version = FightModel.instance:getVersion()

	if version < 4 then
		flow:addWork(FightWork2Work.New(FightWorkDistributeCard))
	end

	flow:addWork(FunctionWork.New(self._dealStartBuff))
	flow:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.BeforeEnterStepBehaviour)
	end))

	local stepWorkList = FightStepBuilder.buildStepWorkList(self.roundData.fightStep)

	if stepWorkList then
		for _, work in ipairs(stepWorkList) do
			flow:addWork(work)
		end
	end

	flow:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.AfterEnterStepBehaviour)
	end))
	flow:addWork(FightWorkSystemFightNoticeView.New())

	if FightController.instance:canOpenRoundView() then
		flow:addWork(FightWorkBeforeStartNoticeView.New())
	end

	flow:addWork(FightWorkCheckOpenRouge2TechniqueView.New())

	local roundViewWork = self:_buildRoundViewWork()

	if roundViewWork then
		flow:addWork(roundViewWork)
	end
end

function FightWorkPlayStart:_buildNormalBorn(flow)
	local parallelFlow = flow:registWork(FightWorkFlowParallel)

	parallelFlow:addWork(FightWorkStartBorn.New())

	local distributeFlow = parallelFlow:registWork(FightWorkFlowSequence)

	distributeFlow:addWork(WorkWaitSeconds.New(1.4 / FightModel.instance:getSpeed()))

	local roundViewWork = self:_buildRoundViewWork()

	if roundViewWork then
		distributeFlow:addWork(roundViewWork)
		distributeFlow:addWork(WorkWaitSeconds.New(0.2 / FightModel.instance:getSpeed()))
	end

	local version = FightModel.instance:getVersion()

	if version < 4 then
		distributeFlow:addWork(FightWork2Work.New(FightWorkDistributeCard))
	end

	flow:addWork(FunctionWork.New(self._dealStartBuff))
	flow:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.BeforeEnterStepBehaviour)
	end))

	local stepWorkList = FightStepBuilder.buildStepWorkList(self.roundData and self.roundData.fightStep)

	if stepWorkList then
		for _, work in ipairs(stepWorkList) do
			flow:addWork(work)
		end
	end

	flow:addWork(FightWorkSystemFightNoticeView.New())

	if FightController.instance:canOpenRoundView() then
		flow:addWork(FightWorkBeforeStartNoticeView.New())
	end

	flow:addWork(FightWorkCheckOpenRouge2TechniqueView.New())
end

function FightWorkPlayStart:_buildRoundViewWork()
	if FightController.instance:canOpenRoundView() and GMFightShowState.roundSpecialView then
		return FunctionWork.New(function()
			FightController.instance:openRoundView()
		end)
	end
end

function FightWorkPlayStart:_dealStartBuff()
	for _, entity in ipairs(FightHelper.getAllEntitys()) do
		if entity.buff then
			entity.buff:dealStartBuff()
		end
	end
end

function FightWorkPlayStart:_setMonsterVisible(visible)
	local enemySideEntitys = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)

	for _, entity in ipairs(enemySideEntitys) do
		entity:setActive(visible)
	end
end

return FightWorkPlayStart
