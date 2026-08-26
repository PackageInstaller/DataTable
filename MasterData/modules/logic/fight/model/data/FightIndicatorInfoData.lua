-- chunkname: @modules/logic/fight/model/data/FightIndicatorInfoData.lua

module("modules.logic.fight.model.data.FightIndicatorInfoData", package.seeall)

local FightIndicatorInfoData = FightDataClass("FightIndicatorInfoData")

function FightIndicatorInfoData:onConstructor(proto)
	self.inticatorId = proto.inticatorId
	self.num = proto.num
end

return FightIndicatorInfoData
