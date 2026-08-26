-- chunkname: @modules/logic/fight/entity/FightEntityRouge2Music.lua

module("modules.logic.fight.entity.FightEntityRouge2Music", package.seeall)

local FightEntityRouge2Music = class("FightEntityRouge2Music", FightEntityObject)

function FightEntityRouge2Music:getTag()
	return SceneTag.UnitNpc
end

function FightEntityRouge2Music:onConstructor()
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntityRouge2Music:initComponents()
	self.skill = self:addEntityComponent(FightSkillComp)
	self.effect = self:addEntityComponent(FightEffectComp)
	self.buff = self:addEntityComponent(FightBuffComp)
end

return FightEntityRouge2Music
