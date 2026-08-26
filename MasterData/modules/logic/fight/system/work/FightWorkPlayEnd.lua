-- chunkname: @modules/logic/fight/system/work/FightWorkPlayEnd.lua

module("modules.logic.fight.system.work.FightWorkPlayEnd", package.seeall)

local FightWorkPlayEnd = class("FightWorkPlayEnd", FightWorkItem)

function FightWorkPlayEnd:onStart()
	local flow = self:com_registFlowSequence()

	FightGameMgr.checkCrashMgr:playEndFight()
	FightController.instance:dispatchEvent(FightEvent.StartFightEnd)
	FightController.instance:dispatchEvent(FightEvent.SwitchFightendBgm)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_fightingsfx)

	local fightRecordMO = FightModel.instance:getRecordMO()

	if fightRecordMO.fightResult == FightEnum.FightResult.Succ then
		flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.Success, FightDataHelper.fieldMgr.battleId))
		self:_addDialogView(flow)
		self:_addCloseFightView(flow)
		flow:addWork(FightWorkEndVictory.New())
		flow:addWork(FightWorkStepShowNoteWhenChangeWave.New())
	else
		flow:addWork(FunctionWork.New(function()
			FightViewPartVisible.set()
			FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
		end))
		flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.FightFail))
		self:_addCloseFightView(flow)
		flow:addWork(FightWorkEndLose.New())
	end

	flow:addWork(FightWorkEndGuide.New())
	flow:addWork(FunctionWork.New(function()
		AudioMgr.instance:trigger(AudioEnum.UI.stop_combatnoise_bus)
	end))
	flow:addWork(FightWorkEndGC.New())

	if FightWorkDirectStartNewFightAfterEndFight.directStartNewFight(FightDataHelper.fieldMgr.episodeId) then
		flow:registWork(FightWorkFunction, FightGameMgr.restartMgr.directStartNewFight, FightGameMgr.restartMgr)
		self:playWorkAndDone(flow, {})

		return
	end

	if fightRecordMO.fightResult == FightEnum.FightResult.Succ and lua_fight_direct_switch_battle_when_end.configDict[FightDataHelper.fieldMgr.battleId] then
		flow:registWork(FightWorkFunction, FightGameMgr.restartMgr.directSwitchBattle, FightGameMgr.restartMgr)
		self:playWorkAndDone(flow, {})

		return
	end

	flow:addWork(FightWorkEndResultViewShow.New())
	flow:addWork(FightWorkSeasonPopupAndStory.New())
	flow:addWork(FightWorkWeekWalkRevive.New())
	flow:addWork(FightWorkAct114RoundEndStory.New())
	flow:addWork(FightWorkCachotResult.New())
	flow:addWork(FightWorkCachotStory.New())
	flow:addWork(FightWorkCachotEnding.New())
	flow:addWork(FightWorkAct183Repress.New())
	flow:addWork(FightWorkAct183Ending.New())
	flow:addWork(FightWorkOpenLoadingBlackView.New())
	flow:registFinishCallback(self.onFlowFinish, self)

	flow.CALLBACK_EVEN_IF_UNFINISHED = true

	self:playWorkAndDone(flow, {})
end

function FightWorkPlayEnd:onFlowFinish()
	DungeonMainStoryModel.instance:saveBattleChapterId(DungeonModel.instance.curSendEpisodeId)
	FightSystem.instance:dispose()
	FightController.instance:exitFightScene()
	FightModel.instance:clearRecordMO()
end

function FightWorkPlayEnd:_addDialogView(flow)
	local currWaveId = FightModel.instance:getCurWaveId()

	FightWorkPlayEnd.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEnd, currWaveId)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEndAndCheckBuffId, currWaveId)

	if FightWorkPlayEnd.needStopMonsterWave then
		flow:addWork(FightWorkWaitDialog.New())
	end
end

function FightWorkPlayEnd:_addCloseFightView(flow)
	flow:addWork(FunctionWork.New(function()
		ViewMgr.instance:closeView(ViewName.FightView)
	end))
end

function FightWorkPlayEnd:replaceEndCallback(callback)
	self._callback = callback
end

return FightWorkPlayEnd
