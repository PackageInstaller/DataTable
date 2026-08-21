-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIWait.lua

module("logic.extensions.ai.impl.action.AIWait", package.seeall)

local M = class("AIWait", AINode)

function M:ctor(context)
	M.super.ctor(self, context)

	self._minWaitTime = 0
	self._maxWaitTime = 0
	self._waitTime = 0
	self._endTime = 0
	self._isReset = false
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._minWaitTime = aiConfigData.minWaitTime
	self._maxWaitTime = aiConfigData.maxWaitTime
	self._isReset = aiConfigData.isReset
end

function M:onStart()
	M.super.onStart(self)

	if self._waitTime <= 0 then
		if self._minWaitTime == self._maxWaitTime then
			self._waitTime = self._minWaitTime
		else
			self._waitTime = math.random(self._minWaitTime, self._maxWaitTime)
		end
	end

	if self._waitTime <= 0 then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	else
		self._endTime = Time.time + self._waitTime
	end

	return self
end

function M:handleEnd()
	self._waitTime = 0
	self._endTime = 0
end

function M:onUpdate()
	if Time.time >= self._endTime then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self
end

function M:onReset()
	M.super.onReset(self)

	if self._isReset then
		local waitTime = self._endTime - Time.time

		self._waitTime = math.max(0, waitTime)
	else
		self._waitTime = 0
	end

	self._endTime = 0
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	M.super.onRecycle(self)

	self._waitTime = 0
	self._endTime = 0
	self._isReset = false
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._waitTime = 0
	self._endTime = 0
	self._isReset = false
end

return M
