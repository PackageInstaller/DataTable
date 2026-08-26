-- chunkname: @modules/logic/fight/fightcomponent/FightTimerComponent.lua

module("modules.logic.fight.fightcomponent.FightTimerComponent", package.seeall)

local FightTimerComponent = class("FightTimerComponent", FightBaseClass)

function FightTimerComponent:onConstructor()
	self.timerList = {}
end

function FightTimerComponent:cancelTimer(timer)
	if not timer then
		return
	end

	timer.isDone = true
end

function FightTimerComponent:registRepeatTimer(callback, handle, time, repeatCount, param)
	local item = FightTimer.registRepeatTimer(callback, handle, time, repeatCount, param)

	table.insert(self.timerList, item)

	return item
end

function FightTimerComponent:restartRepeatTimer(timerItem, time, repeatCount, param)
	return FightTimer.restartRepeatTimer(timerItem, time, repeatCount, param)
end

function FightTimerComponent:registSingleTimer(callback, handle, time, repeatCount, param)
	self.singleTimer = self.singleTimer or {}

	local timerItem = self.singleTimer[callback]

	if timerItem then
		if timerItem.isDone then
			timerItem = self:registRepeatTimer(callback, handle, time, repeatCount, param)
			self.singleTimer[callback] = timerItem

			return timerItem
		else
			timerItem:restart(time, repeatCount, param)

			return timerItem
		end
	else
		timerItem = self:registRepeatTimer(callback, handle, time, repeatCount, param)
		self.singleTimer[callback] = timerItem

		return timerItem
	end
end

function FightTimerComponent:releaseSingleTimer(callback)
	if not self.singleTimer then
		return
	end

	local timerItem = self.singleTimer[callback]

	if timerItem then
		timerItem.isDone = true
		self.singleTimer[callback] = nil
	end
end

function FightTimerComponent:releaseAllTimer()
	for i, item in ipairs(self.timerList) do
		item.isDone = true
	end
end

function FightTimerComponent:onDestructor()
	self:releaseAllTimer()

	self.timerList = nil
	self.singleTimer = nil
end

return FightTimerComponent
