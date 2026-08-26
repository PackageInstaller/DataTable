-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkASFDDone.lua

module("modules.logic.fight.system.work.asfd.FightWorkASFDDone", package.seeall)

local FightWorkASFDDone = class("FightWorkASFDDone", BaseWork)

function FightWorkASFDDone:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkASFDDone:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 3)

	local asfdMgr = FightHelper.getASFDMgr()

	if asfdMgr then
		asfdMgr:onASFDFlowDone(self.fightStepData)
	end

	FightController.instance:dispatchEvent(FightEvent.ASFD_OnDone, self.fightStepData and self.fightStepData.cardIndex)

	return self:onDone(true)
end

function FightWorkASFDDone:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function FightWorkASFDDone:_delayDone()
	logError("奥术飞弹 Done 超时了")

	return self:onDone(true)
end

return FightWorkASFDDone
