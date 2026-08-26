-- chunkname: @modules/logic/gm/view/CustomFightEntityInfoData.lua

module("modules.logic.gm.view.CustomFightEntityInfoData", package.seeall)

local CustomFightEntityInfoData = FightDataClass("CustomFightEntityInfoData")

function CustomFightEntityInfoData:onConstructor(proto)
	self.pos = proto.pos
	self.heroId = proto.heroId
	self.level = proto.level
	self.exLevel = proto.exLevel
	self.equipId = proto.equipId
	self.equipLevel = proto.equipLevel
	self.equipExLevel = proto.equipExLevel
	self.talentLevel = proto.talentLevel
	self.talentStyle = proto.talentStyle
	self.factsId = proto.factsId
	self.extraPassiveSkill = proto.extraPassiveSkill
	self.extraAttr = proto.extraAttr
	self.param = proto.param
end

return CustomFightEntityInfoData
