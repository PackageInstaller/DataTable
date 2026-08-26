-- chunkname: @modules/logic/fight/fightcomponent/FightUpdateComponent.lua

module("modules.logic.fight.fightcomponent.FightUpdateComponent", package.seeall)

local FightUpdateComponent = class("FightUpdateComponent", FightBaseClass)

function FightUpdateComponent:onConstructor()
	self._updateItemList = {}
end

function FightUpdateComponent:registUpdate(func, handle, param)
	local item = FightUpdateMgr.registUpdate(func, handle, param)

	table.insert(self._updateItemList, item)

	return item
end

function FightUpdateComponent:cancelUpdate(item)
	return FightUpdateMgr.cancelUpdate(item)
end

function FightUpdateComponent:onDestructor()
	for i, v in ipairs(self._updateItemList) do
		v.isDone = true
	end
end

return FightUpdateComponent
