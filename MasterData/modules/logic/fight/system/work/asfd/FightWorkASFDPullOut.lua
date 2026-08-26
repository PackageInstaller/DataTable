-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkASFDPullOut.lua

module("modules.logic.fight.system.work.asfd.FightWorkASFDPullOut", package.seeall)

local FightWorkASFDPullOut = class("FightWorkASFDPullOut", BaseWork)

function FightWorkASFDPullOut:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkASFDPullOut:onStart()
	FightController.instance:dispatchEvent(FightEvent.ASFD_PullOut, self.fightStepData)
	TaskDispatcher.runDelay(self._delayDone, self, 0.3)
end

function FightWorkASFDPullOut:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function FightWorkASFDPullOut:_delayDone()
	return self:onDone(true)
end

return FightWorkASFDPullOut
