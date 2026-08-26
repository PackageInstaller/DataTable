-- chunkname: @modules/logic/fight/entity/FightEntityVorpalith.lua

module("modules.logic.fight.entity.FightEntityVorpalith", package.seeall)

local FightEntityVorpalith = class("FightEntityVorpalith", FightEntityObject)

function FightEntityVorpalith:getTag()
	return SceneTag.UnitNpc
end

function FightEntityVorpalith:onConstructor()
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntityVorpalith:initComponents()
	self.skill = self:addEntityComponent(FightSkillComp)
	self.effect = self:addEntityComponent(FightEffectComp)
	self.buff = self:addEntityComponent(FightBuffComp)
	self.vorpalithEventMgr = self:addEntityComponent(FightVorpalithEventMgrComp)
end

return FightEntityVorpalith
