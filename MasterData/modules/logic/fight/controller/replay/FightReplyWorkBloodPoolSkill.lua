-- chunkname: @modules/logic/fight/controller/replay/FightReplyWorkBloodPoolSkill.lua

module("modules.logic.fight.controller.replay.FightReplyWorkBloodPoolSkill", package.seeall)

local FightReplyWorkBloodPoolSkill = class("FightReplyWorkBloodPoolSkill", BaseWork)

function FightReplyWorkBloodPoolSkill:ctor(beginRoundOp)
	self._beginRoundOp = beginRoundOp
end

function FightReplyWorkBloodPoolSkill:onStart(entity)
	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		self:onDone(true)

		return
	end

	if not self._beginRoundOp then
		return self:onDone(true)
	end

	FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, self._beginRoundOp.toId)
	TaskDispatcher.runDelay(self._delayDone, self, 3)

	local bloodPoolSkillId = FightHelper.getBloodPoolSkillId()
	local op = FightDataHelper.operationDataMgr:newOperation()

	op:playBloodPoolCard(bloodPoolSkillId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, op)
	FightDataHelper.bloodPoolDataMgr:playBloodPoolCard()
	self:onDone(true)
end

function FightReplyWorkBloodPoolSkill:_delayDone()
	self:onDone(true)
end

function FightReplyWorkBloodPoolSkill:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightReplyWorkBloodPoolSkill
