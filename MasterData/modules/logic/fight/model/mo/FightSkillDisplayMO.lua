-- chunkname: @modules/logic/fight/model/mo/FightSkillDisplayMO.lua

module("modules.logic.fight.model.mo.FightSkillDisplayMO", package.seeall)

local FightSkillDisplayMO = pureTable("FightSkillDisplayMO")

function FightSkillDisplayMO:ctor()
	self.entityId = nil
	self.skillId = nil
	self.targetId = nil
	self.isCopyCard = nil
end

return FightSkillDisplayMO
