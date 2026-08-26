-- chunkname: @modules/logic/fight/model/data/FightDataCardHeatInfo.lua

module("modules.logic.fight.model.data.FightDataCardHeatInfo", package.seeall)

local FightDataCardHeatInfo = FightDataClass("FightDataCardHeatInfo")

function FightDataCardHeatInfo:onConstructor(proto)
	self.values = {}

	for i, v in ipairs(proto.values) do
		self.values[v.id] = FightDataCardHeatValue.New(v)
	end
end

return FightDataCardHeatInfo
