-- chunkname: @modules/logic/fight/FightTimerItem.lua

module("modules.logic.fight.FightTimerItem", package.seeall)

local FightTimerItem = class("FightTimerItem")
local xpcall = xpcall
local __G__TRACKBACK__ = __G__TRACKBACK__

function FightTimerItem:ctor(time, repeatCount, callback, handle, param)
	self.time = time
	self.originRepeatCount = repeatCount
	self.repeatCount = repeatCount
	self.callback = callback
	self.handle = handle
	self.param = param
	self.updateTime = 0
end

function FightTimerItem:restart(time, repeatCount, param)
	self.updateTime = 0
	self.time = time or self.time
	self.repeatCount = repeatCount or self.originRepeatCount
	self.param = param or self.param
	self.isDone = false
end

function FightTimerItem:update(deltaTime)
	if self.isDone then
		return
	end

	self.updateTime = self.updateTime + deltaTime

	if self.updateTime >= self.time then
		self.updateTime = 0

		if self.repeatCount ~= -1 then
			self.repeatCount = self.repeatCount - 1
		end

		xpcall(self.callback, __G__TRACKBACK__, self.handle, self.param)

		if self.repeatCount == 0 then
			self.isDone = true
		end
	end
end

return FightTimerItem
