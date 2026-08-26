-- chunkname: @modules/logic/fight/model/data/FightAssistBossInfoData.lua

module("modules.logic.fight.model.data.FightAssistBossInfoData", package.seeall)

local FightAssistBossInfoData = FightDataClass("FightAssistBossInfoData")

function FightAssistBossInfoData:onConstructor(proto)
	self.skills = {}

	for i, v in ipairs(proto.skills) do
		table.insert(self.skills, FightAssistBossSkillInfoData.New(v))
	end

	self.currCd = proto.currCd
	self.cdCfg = proto.cdCfg
	self.formId = proto.formId
	self.roundUseLimit = proto.roundUseLimit
	self.exceedUseFree = proto.exceedUseFree
	self.params = proto.params
	self.type = proto.type
end

return FightAssistBossInfoData
