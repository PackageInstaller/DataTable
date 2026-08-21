-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/handler/InertiaHandler.lua

module("logic.common.handler.InertiaHandler", package.seeall)

local M = class("InertiaHandler")
local kDefaultDecelerationRate = 0.9
local kMinSpeed = 0.01

function M:ctor(updateHandler)
	self._speed = 0
	self._decelerationRate = 0
	self._updateHandler = updateHandler
end

function M:start(speed, decelerationRate)
	self._speed = checknumber(speed)
	self._decelerationRate = decelerationRate or kDefaultDecelerationRate
	self._timer = SchedulerCtrl.New(self._update, self)

	self._timer:restart(0, true)
end

function M:_update()
	if not self._updateHandler then
		self:stop()

		return
	end

	self._updateHandler:call(self._speed)

	self._speed = self._speed * self._decelerationRate

	if math.abs(self._speed) < kMinSpeed then
		self:stop()

		if self._stopCallback then
			self._stopCallback(self._stopTarget)
		end
	end
end

function M:stop()
	if self._timer then
		self._timer:stop()
	end
end

function M:setStopCallback(callback, target)
	self._stopCallback = callback
	self._stopTarget = target
end

function M:clear()
	if self._timer then
		self._timer:clear()
	end

	self._timer = nil
	self._speed = 0
	self._decelerationRate = 0
	self._stopCallback = nil
	self._stopTarget = nil
	self._updateHandler = nil
end

return M
