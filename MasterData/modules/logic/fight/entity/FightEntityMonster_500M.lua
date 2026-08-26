-- chunkname: @modules/logic/fight/entity/FightEntityMonster_500M.lua

module("modules.logic.fight.entity.FightEntityMonster_500M", package.seeall)

local FightEntityMonster_500M = class("FightEntityMonster_500M", FightEntityMonster)

function FightEntityMonster_500M:initComponents()
	self.skill = self:addEntityComponent(FightSkillComp)
	self.effect = self:addEntityComponent(FightEffectComp)
	self.buff = self:addEntityComponent(FightBuffComp)
	self.spine = self:addEntityComponent(FightUnitSpine_500M)
	self.spineRenderer = self:addEntityComponent(UnitSpineRenderer_500M)
	self.moveComp = self:addEntityComponent(FightEntityMoveComp)
	self.skinSpineAction = self:addEntityComponent(FightSkinSpineAction)
	self.skinSpineEffect = self:addEntityComponent(FightSkinSpineEffect)
	self.totalDamage = self:addEntityComponent(FightTotalDamageComp)
	self.uniqueEffect = self:addEntityComponent(FightUniqueEffectComp)
	self.skinCustomComp = self:addEntityComponent(FightSkinCustomComp)
	self.nameUI = self:addEntityComponent(FightNameUI)
	self.variantHeart = self:addEntityComponent(FightVariantHeartComp)
	self.entityVisible = self:addEntityComponent(FightEntityVisibleComp)
	self.nameUIVisible = self:addEntityComponent(FightNameUIVisibleComp)
end

function FightEntityMonster_500M:getSpineClass()
	return FightUnitSpine_500M
end

return FightEntityMonster_500M
