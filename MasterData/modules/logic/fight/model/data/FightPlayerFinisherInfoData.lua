-- chunkname: @modules/logic/fight/model/data/FightPlayerFinisherInfoData.lua

module("modules.logic.fight.model.data.FightPlayerFinisherInfoData", package.seeall)

local FightPlayerFinisherInfoData = FightDataClass("FightPlayerFinisherInfoData")

FightPlayerFinisherInfoData.Type = {
	SurvivalTalent = 1,
	Normal = 0
}

function FightPlayerFinisherInfoData:onConstructor(proto)
	self.skills = {}

	for i, v in ipairs(proto.skills) do
		table.insert(self.skills, FightPlayerFinisherSkillInfoData.New(v))
	end

	self.roundUseLimit = proto.roundUseLimit
	self.type = proto.type
end

return FightPlayerFinisherInfoData
