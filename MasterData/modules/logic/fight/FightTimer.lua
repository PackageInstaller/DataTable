-- chunkname: @modules/logic/fight/FightTimer.lua

module("modules.logic.fight.FightTimer", package.seeall)

local FightTimer = class("FightTimer")
local FightTimerItem = FightTimerItem
local timerItems = {}
local listCount = 0
local updateTime = 0
local clearTime = 10

function FightTimer.registTimer(callback, handle, time, param)
	return FightTimer.registRepeatTimer(callback, handle, time, 1, param)
end

function FightTimer.registRepeatTimer(callback, handle, time, repeatCount, param)
	local timerItem = FightTimerItem.New(time, repeatCount, callback, handle, param)

	listCount = listCount + 1
	timerItems[listCount] = timerItem

	return timerItem
end

function FightTimer.cancelTimer(timerItem)
	if not timerItem then
		return
	end

	timerItem.isDone = true
end

function FightTimer.restartRepeatTimer(timerItem, time, repeatCount, param)
	timerItem:restart(time, repeatCount, param)

	listCount = listCount + 1
	timerItems[listCount] = timerItem

	return timerItem
end

function FightTimer.update(handle, deltaTime)
	if listCount == 0 then
		return
	end

	for i = 1, listCount do
		timerItems[i]:update(deltaTime)
	end

	updateTime = updateTime + deltaTime

	if updateTime > clearTime then
		updateTime = 0

		local j = 1

		for i = 1, listCount do
			local item = timerItems[i]

			if not item.isDone then
				if i ~= j then
					timerItems[j] = item
					timerItems[i] = nil
				end

				j = j + 1
			else
				timerItems[i] = nil
			end
		end

		listCount = j - 1
	end
end

FightUpdateMgr.registUpdate(FightTimer.update, FightTimer)

return FightTimer
