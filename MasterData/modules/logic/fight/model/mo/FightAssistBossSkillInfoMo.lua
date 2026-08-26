-- chunkname: @modules/logic/fight/model/mo/FightAssistBossSkillInfoMo.lua

module("modules.logic.fight.model.mo.FightAssistBossSkillInfoMo", package.seeall)

local FightAssistBossSkillInfoMo = pureTable("FightAssistBossSkillInfoMo")

function FightAssistBossSkillInfoMo:init(skillInfo)
	self.skillId = skillInfo.skillId
	self.needPower = skillInfo.needPower
	self.powerLow = skillInfo.powerLow
	self.powerHigh = skillInfo.powerHigh
end

return FightAssistBossSkillInfoMo
