-- chunkname: @modules/logic/fight/entity/FightEntityScene.lua

module("modules.logic.fight.entity.FightEntityScene", package.seeall)

local FightEntityScene = class("FightEntityScene", FightEntityObject)

FightEntityScene.MySideId = "0"
FightEntityScene.EnemySideId = "-99999"

function FightEntityScene:getTag()
	return SceneTag.UnitNpc
end

function FightEntityScene:onConstructor()
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntityScene:initComponents()
	self.skill = self:addEntityComponent(FightSkillComp)
	self.effect = self:addEntityComponent(FightEffectComp)
	self.buff = self:addEntityComponent(FightBuffComp)
end

function FightEntityScene:getSide()
	if self.id == FightEntityScene.MySideId then
		return FightEnum.EntitySide.MySide
	elseif self.id == FightEntityScene.EnemySideId then
		return FightEnum.EntitySide.EnemySide
	else
		return FightEnum.EntitySide.BothSide
	end
end

return FightEntityScene
