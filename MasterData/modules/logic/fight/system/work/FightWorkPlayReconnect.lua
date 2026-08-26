-- chunkname: @modules/logic/fight/system/work/FightWorkPlayReconnect.lua

module("modules.logic.fight.system.work.FightWorkPlayReconnect", package.seeall)

local FightWorkPlayReconnect = class("FightWorkPlayReconnect", FightWorkItem)

function FightWorkPlayReconnect:onStart()
	FightGameMgr.checkCrashMgr:startCheck()

	if FightDataHelper.stateMgr.isReplay then
		FightReplayController.instance._replayErrorFix:startReplayErrorFix()
	end

	local roundData = FightDataHelper.roundMgr:getRoundData()
	local flow = self:com_registFlowSequence()

	flow:addWork(FightGameMgr.necessaryAssetLoaderMgr:registWorkLoadAsset())
	flow:addWork(FightGameMgr.entityMgr:registNewAllEntityWork())
	flow:registWork(FightWorkFunction, ViewMgr.instance.openView, ViewMgr.instance, ViewName.FightSkillSelectView)
	flow:registWork(FightWorkFunction, ViewMgr.instance.openView, ViewMgr.instance, ViewName.FightView)
	flow:addWork(FunctionWork.New(function()
		FightRpc.instance:dealCardInfoPushData()
	end))
	flow:addWork(FightWorkDetectReplayEnterSceneActive.New())
	flow:addWork(FightWorkFbStory.New(FightWorkFbStory.Type_EnterWave))
	flow:addWork(WorkWaitSeconds.New(0.5))
	flow:addWork(FightWorkFocusMonster.New())
	flow:addWork(FunctionWork.New(function()
		for _, entity in ipairs(FightHelper.getAllEntitys()) do
			if entity.buff then
				entity.buff:dealStartBuff()
			end
		end
	end))
	flow:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.BeforeEnterStepBehaviour)
	end))

	local stepWorkList = FightStepBuilder.buildStepWorkList(roundData.fightStep)

	if stepWorkList then
		for _, work in ipairs(stepWorkList) do
			flow:addWork(work)
		end
	end

	flow:addWork(FunctionWork.New(function()
		local roundData = FightDataHelper.roundMgr:getRoundData()

		FightDataMgr.instance:afterPlayRoundData(roundData)
	end))
	flow:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.AfterEnterStepBehaviour)
	end))
	flow:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.OnFightReconnectLastWork)
	end))
	flow:registFinishCallback(self.onFlowFinish, self)
	self:playWorkAndDone(flow, {})
end

function FightWorkPlayReconnect:onFlowFinish()
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.Enter)
	FightController.instance:dispatchEvent(FightEvent.OnStartSequenceFinish)
end

return FightWorkPlayReconnect
