-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkASFDContinueDone.lua

module("modules.logic.fight.system.work.asfd.FightWorkASFDContinueDone", package.seeall)

local FightWorkASFDContinueDone = class("FightWorkASFDContinueDone", BaseWork)

function FightWorkASFDContinueDone:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkASFDContinueDone:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 3)

	local asfdMgr = FightHelper.getASFDMgr()

	if asfdMgr then
		asfdMgr:onContinueASFDFlowDone(self.fightStepData)
	end

	FightController.instance:dispatchEvent(FightEvent.ASFD_OnDone, self.fightStepData and self.fightStepData.cardIndex)

	return self:onDone(true)
end

function FightWorkASFDContinueDone:_delayDone()
	logError("奥术飞弹 Continue Done 超时了")

	return self:onDone(true)
end

function FightWorkASFDContinueDone:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkASFDContinueDone
