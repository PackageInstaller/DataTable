-- chunkname: @modules/logic/battlepass/flow/BpWaitSecWork.lua

module("modules.logic.battlepass.flow.BpWaitSecWork", package.seeall)

local BpWaitSecWork = class("BpWaitSecWork", BaseWork)

function BpWaitSecWork:ctor(sec)
	self._sec = sec or 1
end

function BpWaitSecWork:onStart()
	TaskDispatcher.runDelay(self._delay, self, self._sec)
end

function BpWaitSecWork:_delay()
	self:onDone(true)
end

function BpWaitSecWork:clearWork()
	TaskDispatcher.cancelTask(self._delay, self)
end

return BpWaitSecWork
