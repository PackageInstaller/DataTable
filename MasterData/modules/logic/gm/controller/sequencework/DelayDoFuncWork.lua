-- chunkname: @modules/logic/gm/controller/sequencework/DelayDoFuncWork.lua

module("modules.logic.gm.controller.sequencework.DelayDoFuncWork", package.seeall)

local DelayDoFuncWork = class("DelayDoFuncWork", BaseWork)

function DelayDoFuncWork:ctor(func, target, delayTime, param)
	self._func = func
	self._target = target
	self._delayTime = delayTime
	self._param = param
end

function DelayDoFuncWork:onStart()
	if not self._delayTime or self._delayTime == 0 then
		self.hadDelayTask = false

		self._func(self._target, self._param)
		self:onDone(true)
	else
		self.hadDelayTask = true

		TaskDispatcher.runDelay(self._delayDoFunc, self, self._delayTime)
	end
end

function DelayDoFuncWork:_delayDoFunc()
	self._func(self._target, self._param)
	self:onDone(true)
end

function DelayDoFuncWork:clearWork()
	DelayDoFuncWork.super.clearWork(self)

	if self.hadDelayTask then
		TaskDispatcher.cancelTask(self._delayDoFunc, self)
	end
end

return DelayDoFuncWork
