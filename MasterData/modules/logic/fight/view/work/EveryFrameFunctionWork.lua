-- chunkname: @modules/logic/fight/view/work/EveryFrameFunctionWork.lua

module("modules.logic.fight.view.work.EveryFrameFunctionWork", package.seeall)

local EveryFrameFunctionWork = class("EveryFrameFunctionWork", BaseWork)

function EveryFrameFunctionWork:ctor(func, target, duration, ...)
	self:setParam(func, target, duration, ...)
end

function EveryFrameFunctionWork:setParam(func, target, duration, a1, a2, a3, a4, a5)
	self._func = func
	self._target = target
	self._duration = duration
	self._a1 = a1
	self._a2 = a2
	self._a3 = a3
	self._a4 = a4
	self._a5 = a5
end

function EveryFrameFunctionWork:onStart()
	self.startTime = Time.realtimeSinceStartup
	self.frameHandle = UpdateBeat:CreateListener(self.onFrame, self)

	UpdateBeat:AddListener(self.frameHandle)
	self:onFrame()
end

function EveryFrameFunctionWork:onFrame()
	if self._func then
		self._func(self._target, self._a1, self._a2, self._a3, self._a4, self._a5)
	end

	if Time.realtimeSinceStartup - self.startTime >= self._duration then
		self:removeFrameHandle()
		self:onDone(true)
	end
end

function EveryFrameFunctionWork:removeFrameHandle()
	if self.frameHandle then
		UpdateBeat:RemoveListener(self.frameHandle)

		self.frameHandle = nil
	end
end

function EveryFrameFunctionWork:clearWork()
	self:removeFrameHandle()
end

return EveryFrameFunctionWork
