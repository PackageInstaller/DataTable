-- chunkname: @modules/logic/fight/model/data/FightAssistBossSkillInfoData.lua

module("modules.logic.fight.model.data.FightAssistBossSkillInfoData", package.seeall)

local FightAssistBossSkillInfoData = FightDataClass("FightAssistBossSkillInfoData")

function FightAssistBossSkillInfoData:onConstructor(proto)
	self.skillId = proto.skillId
	self.needPower = proto.needPower
	self.powerLow = proto.powerLow
	self.powerHigh = proto.powerHigh
end

return FightAssistBossSkillInfoData
