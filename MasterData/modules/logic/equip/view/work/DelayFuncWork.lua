-- chunkname: @modules/logic/equip/view/work/DelayFuncWork.lua

module("modules.logic.equip.view.work.DelayFuncWork", package.seeall)

local DelayFuncWork = class("DelayFuncWork", BaseWork)

function DelayFuncWork:ctor(func, target, delayTime, param)
	self._func = func
	self._target = target
	self._delayTime = delayTime
	self._param = param
end

function DelayFuncWork:onStart()
	self._func(self._target, self._param)

	if not self._delayTime or self._delayTime == 0 then
		self.hadDelayTask = false

		self:onDone(true)
	else
		self.hadDelayTask = true

		TaskDispatcher.runDelay(self._delayDone, self, self._delayTime)
	end
end

function DelayFuncWork:_delayDone()
	self:onDone(true)
end

function DelayFuncWork:clearWork()
	DelayFuncWork.super.clearWork(self)

	if self.hadDelayTask then
		TaskDispatcher.cancelTask(self._delayDone, self)
	end
end

return DelayFuncWork
