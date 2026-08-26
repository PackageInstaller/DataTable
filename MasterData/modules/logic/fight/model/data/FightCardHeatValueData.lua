-- chunkname: @modules/logic/fight/model/data/FightCardHeatValueData.lua

module("modules.logic.fight.model.data.FightCardHeatValueData", package.seeall)

local FightCardHeatValueData = FightDataClass("FightCardHeatValueData")

function FightCardHeatValueData:onConstructor(proto)
	self.id = proto.id
	self.upperLimit = proto.upperLimit
	self.lowerLimit = proto.lowerLimit
	self.value = proto.value
	self.changeValue = proto.changeValue
end

return FightCardHeatValueData
