-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/time/SchedulerCtrl.lua

module("logic.common.time.SchedulerCtrl", package.seeall)

local M = class("SchedulerCtrl")

function M.NewWithHandler(handler)
	local ctrl = SchedulerCtrl.New()

	ctrl:setHandler(handler)

	return ctrl
end

function M:ctor(callback, target)
	self._timerCallback = callback
	self._timerTarget = target
	self._handler = nil
	self._doingTimer = false
	self._isLoop = false
end

function M:setHandler(handler)
	self._handler = handler
end

function M:restart(time, isLoop)
	self:stop()

	self._doingTimer = true
	self._isLoop = isLoop

	if time >= 0 then
		settimer(time, self._doTimerCallback, self, isLoop)
	else
		self:_doTimerCallback()
	end
end

function M:stop()
	if self._doingTimer then
		self._doingTimer = false

		removetimer(self._doTimerCallback, self)
	end
end

function M:clear()
	self:stop()

	self._timerCallback = nil
	self._timerTarget = nil
	self._handler = nil
end

function M:_doTimerCallback()
	if not self._isLoop then
		self._doingTimer = false
	end

	if self._timerCallback then
		self._timerCallback(self._timerTarget)
	else
		self._handler:call()
	end
end

return M
