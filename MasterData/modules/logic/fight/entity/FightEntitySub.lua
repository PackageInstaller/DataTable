-- chunkname: @modules/logic/fight/entity/FightEntitySub.lua

module("modules.logic.fight.entity.FightEntitySub", package.seeall)

local FightEntitySub = class("FightEntitySub", FightEntityObject)

FightEntitySub.Online = true

function FightEntitySub:getTag()
	return (self:isMySide() or nil) and (SceneTag.UnitPlayer or SceneTag.UnitMonster)
end

function FightEntitySub:onConstructor()
	self.isSub = true
end

function FightEntitySub:initComponents()
	self.effect = self:addEntityComponent(FightEffectComp)
	self.spine = self:addEntityComponent(FightSpineComp)
	self.spineRenderer = self:addEntityComponent(FightSpineRendererComp)
	self.moveComp = self:addEntityComponent(FightEntityMoveComp)
	self.entityVisible = self:addEntityComponent(FightEntityVisibleComp)
	self.variantCrayon = self:addEntityComponent(FightVariantCrayonComp)
end

function FightEntitySub:setRenderOrder(order)
	FightEntitySub.super.setRenderOrder(self, order)
end

function FightEntitySub:setAlpha(alpha, duration)
	if self.spineRenderer then
		self.spineRenderer:setAlpha(alpha, duration)
	end
end

return FightEntitySub
