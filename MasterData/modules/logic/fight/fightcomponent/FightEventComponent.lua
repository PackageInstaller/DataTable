-- chunkname: @modules/logic/fight/fightcomponent/FightEventComponent.lua

module("modules.logic.fight.fightcomponent.FightEventComponent", package.seeall)

local FightEventComponent = class("FightEventComponent", FightBaseClass)

function FightEventComponent:onConstructor()
	self._eventItems = {}
end

function FightEventComponent:registEvent(ctrl, eventId, callback, handle, priority)
	for i, item in ipairs(self._eventItems) do
		if ctrl == item[1] and eventId == item[2] and callback == item[3] and handle == item[4] then
			return
		end
	end

	ctrl:registerCallback(eventId, callback, handle, priority)
	table.insert(self._eventItems, {
		ctrl,
		eventId,
		callback,
		handle,
		priority
	})
end

function FightEventComponent:cancelEvent(ctrl, eventId, callback, handle)
	for i = #self._eventItems, 1, -1 do
		local item = self._eventItems[i]

		if ctrl == item[1] and eventId == item[2] and callback == item[3] and handle == item[4] then
			ctrl:unregisterCallback(eventId, callback, handle)
			table.remove(self._eventItems, i)
		end
	end
end

function FightEventComponent:onDestructor()
	for i = #self._eventItems, 1, -1 do
		local item = self._eventItems[i]

		item[1]:unregisterCallback(item[2], item[3], item[4])
	end

	self._eventItems = nil
end

return FightEventComponent
