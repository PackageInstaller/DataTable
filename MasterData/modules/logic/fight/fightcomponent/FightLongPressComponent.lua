-- chunkname: @modules/logic/fight/fightcomponent/FightLongPressComponent.lua

module("modules.logic.fight.fightcomponent.FightLongPressComponent", package.seeall)

local FightLongPressComponent = class("FightLongPressComponent", FightBaseClass)

function FightLongPressComponent:onConstructor()
	self._longPressArr = {
		0.5,
		99999
	}
	self._pressDic = {}
end

function FightLongPressComponent:registLongPress(longPress, callback, handle, param)
	local id = longPress:GetInstanceID()

	self._pressDic[id] = longPress

	longPress:SetLongPressTime(self._longPressArr)
	longPress:AddLongPressListener(callback, handle, param)
end

function FightLongPressComponent:registHover(longPress, callback, handle)
	local id = longPress:GetInstanceID()

	self._pressDic[id] = longPress

	longPress:AddHoverListener(callback, handle)
end

function FightLongPressComponent:removeLongPress(longPress)
	local id = longPress:GetInstanceID()

	if self._pressDic[id] then
		self._pressDic[id]:RemoveLongPressListener()
	end
end

function FightLongPressComponent:removeHover(longPress)
	local id = longPress:GetInstanceID()

	if self._pressDic[id] then
		self._pressDic[id]:RemoveHoverListener()
	end
end

function FightLongPressComponent:onDestructor()
	for k, longPress in pairs(self._pressDic) do
		longPress:RemoveLongPressListener()
		longPress:RemoveHoverListener()
	end
end

return FightLongPressComponent
