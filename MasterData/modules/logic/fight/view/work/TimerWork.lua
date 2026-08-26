-- chunkname: @modules/logic/fight/view/work/TimerWork.lua

module("modules.logic.fight.view.work.TimerWork", package.seeall)

local TimerWork = class("TimerWork", BaseWork)

function TimerWork:ctor(time)
	self._time = time
end

function TimerWork:onStart()
	TaskDispatcher.runDelay(self._onTimeout, self, self._time)
end

function TimerWork:_onTimeout()
	self:onDone(true)
end

function TimerWork:clearWork()
	TaskDispatcher.cancelTask(self._onTimeout, self)
end

return TimerWork
