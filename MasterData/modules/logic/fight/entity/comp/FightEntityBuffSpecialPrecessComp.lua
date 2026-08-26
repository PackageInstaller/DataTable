-- chunkname: @modules/logic/fight/entity/comp/FightEntityBuffSpecialPrecessComp.lua

module("modules.logic.fight.entity.comp.FightEntityBuffSpecialPrecessComp", package.seeall)

local FightEntityBuffSpecialPrecessComp = class("FightEntityBuffSpecialPrecessComp", FightBaseClass)

function FightEntityBuffSpecialPrecessComp:onLogicEnter(entity)
	self._entity = entity

	self:com_registFightEvent(FightEvent.AddEntityBuff, self._onAddEntityBuff)
end

function FightEntityBuffSpecialPrecessComp:_onAddEntityBuff(entityId, buffMO)
	if entityId ~= self._entity.id then
		return
	end

	self:_registBuffIdClass(buffMO.buffId, buffMO.uid)
end

local buffId2Class = {
	[4150022] = FightBuffJuDaBenYePuDormancyHand,
	[4150023] = FightBuffJuDaBenYePuDormancyTail
}

function FightEntityBuffSpecialPrecessComp:_registBuffIdClass(buffId, buffUid)
	if buffId2Class[buffId] then
		self:newClass(buffId2Class[buffId], self._entity, buffId, buffUid)
	end
end

function FightEntityBuffSpecialPrecessComp:onLogicExit()
	return
end

return FightEntityBuffSpecialPrecessComp
