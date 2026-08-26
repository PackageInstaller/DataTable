-- chunkname: @modules/logic/fight/entity/FightEntityASFD.lua

module("modules.logic.fight.entity.FightEntityASFD", package.seeall)

local FightEntityASFD = class("FightEntityASFD", FightEntityObject)

function FightEntityASFD:getTag()
	return SceneTag.UnitNpc
end

function FightEntityASFD:onConstructor()
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntityASFD:initComponents()
	self.effect = self:addEntityComponent(FightEffectComp)
end

return FightEntityASFD
