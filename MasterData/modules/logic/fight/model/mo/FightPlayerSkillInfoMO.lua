-- chunkname: @modules/logic/fight/model/mo/FightPlayerSkillInfoMO.lua

module("modules.logic.fight.model.mo.FightPlayerSkillInfoMO", package.seeall)

local FightPlayerSkillInfoMO = pureTable("FightPlayerSkillInfoMO")

function FightPlayerSkillInfoMO:init(info)
	self.skillId = info.skillId
	self.cd = info.cd
	self.needPower = info.needPower
	self.type = info.type
end

return FightPlayerSkillInfoMO
