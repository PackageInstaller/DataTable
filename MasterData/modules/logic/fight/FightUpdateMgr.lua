-- chunkname: @modules/logic/fight/FightUpdateMgr.lua

module("modules.logic.fight.FightUpdateMgr", package.seeall)

local FightUpdateMgr = class("FightUpdateMgr")
local FightUpdateItem = FightUpdateItem
local Time = Time
local updateItems = {}
local listCount = 0
local updateTime = 0
local clearTime = 10

function FightUpdateMgr.registUpdate(func, handle, param)
	local item = FightUpdateItem.New(func, handle, param)

	listCount = listCount + 1
	updateItems[listCount] = item

	return item
end

function FightUpdateMgr.cancelUpdate(item)
	if not item then
		return
	end

	item.isDone = true
end

function FightUpdateMgr.update()
	if listCount == 0 then
		return
	end

	local delta = Time.deltaTime

	for i = 1, listCount do
		updateItems[i]:update(delta)
	end

	updateTime = updateTime + delta

	if updateTime > clearTime then
		updateTime = 0

		local j = 1

		for i = 1, listCount do
			local item = updateItems[i]

			if not item.isDone then
				if i ~= j then
					updateItems[j] = item
					updateItems[i] = nil
				end

				j = j + 1
			else
				updateItems[i] = nil
			end
		end

		listCount = j - 1
	end
end

UpdateBeat:Add(FightUpdateMgr.update, FightUpdateMgr)

return FightUpdateMgr
