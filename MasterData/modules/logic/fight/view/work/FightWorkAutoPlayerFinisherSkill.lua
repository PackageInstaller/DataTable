-- chunkname: @modules/logic/fight/view/work/FightWorkAutoPlayerFinisherSkill.lua

module("modules.logic.fight.view.work.FightWorkAutoPlayerFinisherSkill", package.seeall)

local FightWorkAutoPlayerFinisherSkill = class("FightWorkAutoPlayerFinisherSkill", FightWorkItem)

function FightWorkAutoPlayerFinisherSkill:onConstructor(beginRoundOp)
	self._beginRoundOp = beginRoundOp
	self.SAFETIME = 5
end

function FightWorkAutoPlayerFinisherSkill:onStart(entity)
	if not self._beginRoundOp then
		return self:onDone(true)
	end

	FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, self._beginRoundOp.toId)

	local op = FightDataHelper.operationDataMgr:newOperation()

	op:playPlayerFinisherSkill(self._beginRoundOp.param1, self._beginRoundOp.toId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, op)
	self:onDone(true)
end

return FightWorkAutoPlayerFinisherSkill
