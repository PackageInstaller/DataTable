-- chunkname: @modules/logic/fight/fightcomponent/FightDragComponent.lua

module("modules.logic.fight.fightcomponent.FightDragComponent", package.seeall)

local FightDragComponent = class("FightDragComponent", FightBaseClass)

function FightDragComponent:onConstructor()
	self._dragDic = {}
end

function FightDragComponent:registDragBegin(drag, callback, handle, param)
	local id = drag:GetInstanceID()

	self._dragDic[id] = drag

	drag:AddDragBeginListener(callback, handle, param)
end

function FightDragComponent:registDrag(drag, callback, handle, param)
	local id = drag:GetInstanceID()

	self._dragDic[id] = drag

	drag:AddDragListener(callback, handle, param)
end

function FightDragComponent:registDragEnd(drag, callback, handle, param)
	local id = drag:GetInstanceID()

	self._dragDic[id] = drag

	drag:AddDragEndListener(callback, handle, param)
end

function FightDragComponent:removeDragBegin(drag)
	local id = drag:GetInstanceID()

	if self._dragDic[id] then
		self._dragDic[id]:RemoveDragBeginListener()
	end
end

function FightDragComponent:removeDrag(drag)
	local id = drag:GetInstanceID()

	if self._dragDic[id] then
		self._dragDic[id]:RemoveDragListener()
	end
end

function FightDragComponent:removeDragEnd(drag)
	local id = drag:GetInstanceID()

	if self._dragDic[id] then
		self._dragDic[id]:RemoveDragEndListener()
	end
end

function FightDragComponent:onDestructor()
	for k, drag in pairs(self._dragDic) do
		drag:RemoveDragBeginListener()
		drag:RemoveDragListener()
		drag:RemoveDragEndListener()
	end
end

return FightDragComponent
