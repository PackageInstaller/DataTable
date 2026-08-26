-- chunkname: @modules/logic/fight/fightcomponent/FightClickComponent.lua

module("modules.logic.fight.fightcomponent.FightClickComponent", package.seeall)

local FightClickComponent = class("FightClickComponent", FightBaseClass)

function FightClickComponent:onConstructor()
	self._clickDic = {}
end

function FightClickComponent:registClick(click, callback, handle, param)
	local id = click:GetInstanceID()

	self._clickDic[id] = click

	click:AddClickListener(callback, handle, param)
end

function FightClickComponent:removeClick(click)
	local id = click:GetInstanceID()

	if self._clickDic[id] then
		self._clickDic[id]:RemoveClickListener()

		self._clickDic[id] = nil
	end
end

function FightClickComponent:onDestructor()
	for k, v in pairs(self._clickDic) do
		v:RemoveClickListener()
	end
end

return FightClickComponent
