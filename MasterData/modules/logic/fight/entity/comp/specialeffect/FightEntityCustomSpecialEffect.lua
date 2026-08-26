-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntityCustomSpecialEffect.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntityCustomSpecialEffect", package.seeall)

local FightEntityCustomSpecialEffect = class("FightEntityCustomSpecialEffect", FightBaseClass)

function FightEntityCustomSpecialEffect:onConstructor(entity)
	self.entity = entity

	local entityDic = FightDataHelper.entityMgr:getAllEntityMO()

	for k, v in pairs(entityDic) do
		if v.modelId == 3079 then
			self:newClass(FightEntitySpecialEffect3079_Buff, self.entity)

			break
		end
	end

	self:newClass(FightEntitySpecialEffect3070_Ball, self.entity)
	self:newClass(FightEntitySpecialEffectBuffLayer, self.entity)
	self:newClass(FightEntitySpecialEffectBuffLayerEnemySkin, self.entity)
	self:newClass(FightEntitySpecialEffect3081_Ball, self.entity)
	self:newClass(FightEntitySpecialEffectSeasonChangeHero, self.entity)
	self:newClass(FightEntitySpecialEffectBuffLayerNaNa, self.entity)
	self:newClass(FightEntitySpecialEffectBuffLayerLZL, self.entity)
end

return FightEntityCustomSpecialEffect
