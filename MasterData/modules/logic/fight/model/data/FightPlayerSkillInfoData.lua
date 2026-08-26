-- chunkname: @modules/logic/fight/model/data/FightPlayerSkillInfoData.lua

module("modules.logic.fight.model.data.FightPlayerSkillInfoData", package.seeall)

local FightPlayerSkillInfoData = FightDataClass("FightPlayerSkillInfoData")

function FightPlayerSkillInfoData:onConstructor(proto)
	self.skillId = proto.skillId
	self.cd = proto.cd
	self.needPower = proto.needPower
	self.type = proto.type
end

return FightPlayerSkillInfoData
