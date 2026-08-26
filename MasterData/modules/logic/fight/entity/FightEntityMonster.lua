-- chunkname: @modules/logic/fight/entity/FightEntityMonster.lua

module("modules.logic.fight.entity.FightEntityMonster", package.seeall)

local FightEntityMonster = class("FightEntityMonster", FightEntityObject)

function FightEntityMonster:getTag()
	return SceneTag.UnitMonster
end

function FightEntityMonster:initComponents()
	FightEntityMonster.super.initComponents(self)

	self.variantHeart = self:addEntityComponent(FightVariantHeartComp)
	self.entityVisible = self:addEntityComponent(FightEntityVisibleComp)
	self.nameUIVisible = self:addEntityComponent(FightNameUIVisibleComp)
end

return FightEntityMonster
