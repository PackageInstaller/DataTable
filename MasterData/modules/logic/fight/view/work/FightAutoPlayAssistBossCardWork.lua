-- chunkname: @modules/logic/fight/view/work/FightAutoPlayAssistBossCardWork.lua

module("modules.logic.fight.view.work.FightAutoPlayAssistBossCardWork", package.seeall)

local FightAutoPlayAssistBossCardWork = class("FightAutoPlayAssistBossCardWork", BaseWork)

function FightAutoPlayAssistBossCardWork:ctor(beginRoundOp)
	self._beginRoundOp = beginRoundOp
end

function FightAutoPlayAssistBossCardWork:onStart(entity)
	if self._beginRoundOp then
		FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, self._beginRoundOp.toId)
	end

	if not self._beginRoundOp then
		return self:onDone(true)
	end

	TaskDispatcher.runDelay(self._delayDone, self, 3)

	local op = FightDataHelper.operationDataMgr:newOperation()

	op:playAssistBossHandCard(self._beginRoundOp.param1, self._beginRoundOp.toId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, op)
	FightDataHelper.paTaMgr:playAssistBossSkillBySkillId(op.param1)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossPowerChange)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossCDChange)
	self:onDone(true)
end

function FightAutoPlayAssistBossCardWork:_delayDone()
	logError("自动战斗打协助boss牌超时")
	self:onDone(true)
end

function FightAutoPlayAssistBossCardWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightAutoPlayAssistBossCardWork
