-- chunkname: @modules/logic/fight/model/data/FightItemPlayerSkillInfoData.lua

module("modules.logic.fight.model.data.FightItemPlayerSkillInfoData", package.seeall)

local FightItemPlayerSkillInfoData = FightDataClass("FightItemPlayerSkillInfoData")

function FightItemPlayerSkillInfoData:onConstructor(proto)
	self.skillId = proto.skillId
	self.itemId = proto.itemId
	self.cd = proto.cd
	self.count = proto.count
end

return FightItemPlayerSkillInfoData
