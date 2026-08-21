-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/handler/TimeWaiter.lua

module("logic.common.handler.TimeWaiter", package.seeall)

local TimeWaiter = class("TimeWaiter", AbstractGlobalReusable)

function TimeWaiter:ctor()
	self._duration = 0
	self._timeScale = 1
	self._handler = Handler.New()
end

function TimeWaiter:reset()
	self:clear()
end

function TimeWaiter:destroy()
	self:clear()
end

function TimeWaiter:start(duration, callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)

	self._duration = duration

	FrameUpdate:addListener(self)
end

function TimeWaiter:setTimeScale(timeScale)
	self._timeScale = timeScale
end

function TimeWaiter:clear()
	FrameUpdate:removeListener(self)
	self._handler:clear()

	self._duration = 0
	self._timeScale = 1
end

function TimeWaiter:luaUpdate(deltaTime)
	self._duration = self._duration - deltaTime * self._timeScale

	if self._duration <= 0 then
		FrameUpdate:removeListener(self)
		self:_onTimerDone()
	end
end

function TimeWaiter:_onTimerDone()
	self._handler:callAndClear(self)
end

return TimeWaiter
