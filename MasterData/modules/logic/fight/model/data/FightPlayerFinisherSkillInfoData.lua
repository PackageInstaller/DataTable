-- chunkname: @modules/logic/fight/model/data/FightPlayerFinisherSkillInfoData.lua

module("modules.logic.fight.model.data.FightPlayerFinisherSkillInfoData", package.seeall)

local FightPlayerFinisherSkillInfoData = FightDataClass("FightPlayerFinisherSkillInfoData")

function FightPlayerFinisherSkillInfoData:onConstructor(proto)
	self.skillId = proto.skillId
	self.needPower = proto.needPower
end

return FightPlayerFinisherSkillInfoData
