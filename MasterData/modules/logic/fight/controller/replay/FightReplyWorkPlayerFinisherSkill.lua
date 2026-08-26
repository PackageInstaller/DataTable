-- chunkname: @modules/logic/fight/controller/replay/FightReplyWorkPlayerFinisherSkill.lua

module("modules.logic.fight.controller.replay.FightReplyWorkPlayerFinisherSkill", package.seeall)

local FightReplyWorkPlayerFinisherSkill = class("FightReplyWorkPlayerFinisherSkill", BaseWork)

function FightReplyWorkPlayerFinisherSkill:ctor(beginRoundOp)
	self._beginRoundOp = beginRoundOp
end

function FightReplyWorkPlayerFinisherSkill:onStart(entity)
	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		self:onDone(true)

		return
	end

	if not self._beginRoundOp then
		return self:onDone(true)
	end

	FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, self._beginRoundOp.toId)
	TaskDispatcher.runDelay(self._delayDone, self, 3)

	local op = FightDataHelper.operationDataMgr:newOperation()

	op:playPlayerFinisherSkill(self._beginRoundOp.param1, self._beginRoundOp.toId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, op)
	self:onDone(true)
end

function FightReplyWorkPlayerFinisherSkill:_delayDone()
	self:onDone(true)
end

function FightReplyWorkPlayerFinisherSkill:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightReplyWorkPlayerFinisherSkill
