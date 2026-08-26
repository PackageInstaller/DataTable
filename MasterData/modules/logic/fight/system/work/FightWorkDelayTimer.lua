-- chunkname: @modules/logic/fight/system/work/FightWorkDelayTimer.lua

module("modules.logic.fight.system.work.FightWorkDelayTimer", package.seeall)

local FightWorkDelayTimer = class("FightWorkDelayTimer", FightWorkItem)

function FightWorkDelayTimer:onLogicEnter(waitSeconds)
	self._waitSeconds = waitSeconds or 0.01
end

function FightWorkDelayTimer:onStart()
	if self._waitSeconds == 0 then
		self:onDone(true)

		return
	end

	self:cancelFightWorkSafeTimer()
	self:com_registTimer(self._onTimeEnd, self._waitSeconds)
end

function FightWorkDelayTimer:clearWork()
	return
end

function FightWorkDelayTimer:_onTimeEnd()
	self:onDone(true)
end

return FightWorkDelayTimer
