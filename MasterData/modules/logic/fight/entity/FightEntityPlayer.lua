-- chunkname: @modules/logic/fight/entity/FightEntityPlayer.lua

module("modules.logic.fight.entity.FightEntityPlayer", package.seeall)

local FightEntityPlayer = class("FightEntityPlayer", FightEntityObject)

function FightEntityPlayer:getTag()
	return SceneTag.UnitPlayer
end

function FightEntityPlayer:initComponents()
	FightEntityPlayer.super.initComponents(self)

	self.readyAttack = self:addEntityComponent(FightPlayerReadyAttackComp)
	self.variantCrayon = self:addEntityComponent(FightVariantCrayonComp)
	self.entityVisible = self:addEntityComponent(FightEntityVisibleComp)
	self.nameUIVisible = self:addEntityComponent(FightNameUIVisibleComp)
	self.variantHeart = self:addEntityComponent(FightVariantHeartComp)
	self.heroCustomComp = self:addEntityComponent(FightHeroCustomComp)
end

return FightEntityPlayer
