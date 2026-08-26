-- chunkname: @modules/logic/fight/controller/replay/FightReplayWorkWaitCardStage.lua

module("modules.logic.fight.controller.replay.FightReplayWorkWaitCardStage", package.seeall)

local FightReplayWorkWaitCardStage = class("FightReplayWorkWaitCardStage", BaseWork)

function FightReplayWorkWaitCardStage:ctor()
	return
end

function FightReplayWorkWaitCardStage:onStart()
	local stage = FightDataHelper.stageMgr:getCurStage()

	if stage == FightStageMgr.StageType.Operate then
		self:onDone(true)
	else
		FightController.instance:registerCallback(FightEvent.StageChanged, self.onStageChange, self)
	end
end

function FightReplayWorkWaitCardStage:onStageChange(stageType)
	if stageType == FightStageMgr.StageType.Operate then
		FightController.instance:unregisterCallback(FightEvent.StageChanged, self.onStageChange, self)
		self:onDone(true)
	end
end

function FightReplayWorkWaitCardStage:clearWork()
	FightController.instance:unregisterCallback(FightEvent.StageChanged, self.onStageChange, self)
end

return FightReplayWorkWaitCardStage
