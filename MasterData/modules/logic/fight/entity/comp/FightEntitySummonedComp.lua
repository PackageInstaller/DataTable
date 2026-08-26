-- chunkname: @modules/logic/fight/entity/comp/FightEntitySummonedComp.lua

module("modules.logic.fight.entity.comp.FightEntitySummonedComp", package.seeall)

local FightEntitySummonedComp = class("FightEntitySummonedComp", FightBaseClass)

function FightEntitySummonedComp:onLogicEnter(entity)
	self._entity = entity

	self:com_registFightEvent(FightEvent.SummonedAdd, self._onSummonedAdd)
	self:_refreshSummoned()
end

function FightEntitySummonedComp:_refreshSummoned()
	local entityMO = self._entity:getMO()
	local summonedInfo = entityMO:getSummonedInfo()
	local dataDic = summonedInfo:getDataDic()

	for k, data in pairs(dataDic) do
		self:_instantiateSummoned(data)
	end
end

function FightEntitySummonedComp:_instantiateSummoned(data)
	local classname = "FightEntitySummonedItem" .. data.summonedId

	if _G[classname] then
		self:newClass(_G[classname], self._entity, data)
	else
		self:newClass(FightEntitySummonedItem, self._entity, data)
	end
end

function FightEntitySummonedComp:_onSummonedAdd(entityId, data)
	if entityId ~= self._entity.id then
		return
	end

	self:_instantiateSummoned(data)
end

function FightEntitySummonedComp:onLogicExit()
	return
end

return FightEntitySummonedComp
