-- chunkname: @modules/common/work/DelayWork.lua

module("modules.common.work.DelayWork", package.seeall)

local DelayWork = class("DelayWork", BaseWork)

function DelayWork:ctor(delay)
	self.delay = delay
end

function DelayWork:onStart()
	TaskDispatcher.runDelay(self.onDelayDone, self, self.delay)
end

function DelayWork:onDelayDone(viewName)
	return self:onDone(true)
end

function DelayWork:clearWork()
	TaskDispatcher.cancelTask(self.onDelayDone, self)
end

return DelayWork
