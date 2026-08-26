-- chunkname: @modules/logic/fight/model/data/FightHeroSpAttributeInfoData.lua

module("modules.logic.fight.model.data.FightHeroSpAttributeInfoData", package.seeall)

local FightHeroSpAttributeInfoData = FightDataClass("FightHeroSpAttributeInfoData")

function FightHeroSpAttributeInfoData:onConstructor(proto)
	self.uid = proto.uid
	self.attribute = FightHeroSpAttributeData.New(proto.attribute)
end

return FightHeroSpAttributeInfoData
