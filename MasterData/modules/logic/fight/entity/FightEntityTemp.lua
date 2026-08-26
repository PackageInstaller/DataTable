-- chunkname: @modules/logic/fight/entity/FightEntityTemp.lua

module("modules.logic.fight.entity.FightEntityTemp", package.seeall)

local FightEntityTemp = class("FightEntityTemp", FightEntityObject)

function FightEntityTemp:getTag()
	return SceneTag.UnitNpc
end

function FightEntityTemp:onConstructor()
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntityTemp:initComponents()
	self.effect = self:addEntityComponent(FightEffectComp)
	self.spine = self:addEntityComponent(FightUnitSpine)
	self.spineRenderer = self:addEntityComponent(FightSpineRendererComp)
	self.moveComp = self:addEntityComponent(FightEntityMoveComp)
	self.variantHeart = self:addEntityComponent(FightVariantHeartComp)
	self.entityVisible = self:addEntityComponent(FightEntityVisibleComp)
end

return FightEntityTemp
