-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkWaitASFDArrivedDone.lua

module("modules.logic.fight.system.work.asfd.FightWorkWaitASFDArrivedDone", package.seeall)

local FightWorkWaitASFDArrivedDone = class("FightWorkWaitASFDArrivedDone", BaseWork)

function FightWorkWaitASFDArrivedDone:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkWaitASFDArrivedDone:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 5)
	FightController.instance:registerCallback(FightEvent.ASFD_OnASFDArrivedDone, self.onASFDArrivedDone, self)
end

function FightWorkWaitASFDArrivedDone:onASFDArrivedDone(fightStepData)
	if fightStepData ~= self.fightStepData then
		return
	end

	return self:onDone(true)
end

function FightWorkWaitASFDArrivedDone:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	FightController.instance:unregisterCallback(FightEvent.ASFD_OnASFDArrivedDone, self.onASFDArrivedDone, self)
end

function FightWorkWaitASFDArrivedDone:_delayDone()
	logError("奥术飞弹 wait arrived 超时了")

	return self:onDone(true)
end

return FightWorkWaitASFDArrivedDone
