-- chunkname: @modules/logic/fight/entity/effect/FightBuffYaMiHuTiEffect.lua

module("modules.logic.fight.entity.effect.FightBuffYaMiHuTiEffect", package.seeall)

local FightBuffYaMiHuTiEffect = class("FightBuffYaMiHuTiEffect", FightBaseClass)

function FightBuffYaMiHuTiEffect:onConstructor(entity)
	self.entity = entity
	self.entityId = entity.id

	self:com_registMsg(FightMsgId.OnAddYaMiShield, self.onAddYaMiShield)
end

function FightBuffYaMiHuTiEffect:onAddYaMiShield(buffData, actInfo)
	if buffData.entityId ~= self.entityId then
		return
	end

	self:newClass(FightBuffYaMiHuTiEffectItem, self.entity, buffData, actInfo)
end

return FightBuffYaMiHuTiEffect
