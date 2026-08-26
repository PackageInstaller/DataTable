-- chunkname: @modules/logic/fight/model/data/FightDeviceSkillGroupInfoData.lua

module("modules.logic.fight.model.data.FightDeviceSkillGroupInfoData", package.seeall)

local FightDeviceSkillGroupInfoData = FightDataClass("FightDeviceSkillGroupInfoData")

function FightDeviceSkillGroupInfoData:onConstructor(proto)
	self.skills = {}

	for _, v in ipairs(proto.skills) do
		table.insert(self.skills, FightDeviceSkillInfoData.New(v))
	end
end

function FightDeviceSkillGroupInfoData:resetStopAttr()
	for _, skill in ipairs(self.skills) do
		skill:resetStopAttr()
	end
end

function FightDeviceSkillGroupInfoData:getCount()
	return #self.skills
end

return FightDeviceSkillGroupInfoData
