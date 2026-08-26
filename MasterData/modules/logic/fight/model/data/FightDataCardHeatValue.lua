-- chunkname: @modules/logic/fight/model/data/FightDataCardHeatValue.lua

module("modules.logic.fight.model.data.FightDataCardHeatValue", package.seeall)

local FightDataCardHeatValue = FightDataClass("FightDataCardHeatValue")

function FightDataCardHeatValue:onConstructor(proto)
	self.id = proto.id
	self.upperLimit = proto.upperLimit
	self.lowerLimit = proto.lowerLimit
	self.value = proto.value
	self.changeValue = proto.changeValue
end

return FightDataCardHeatValue
