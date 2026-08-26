-- chunkname: @modules/logic/fight/model/data/FightCardHeatInfoData.lua

module("modules.logic.fight.model.data.FightCardHeatInfoData", package.seeall)

local FightCardHeatInfoData = FightDataClass("FightCardHeatInfoData")

function FightCardHeatInfoData:onConstructor(proto)
	self.values = {}

	for i, v in ipairs(proto.values) do
		table.insert(self.values, FightCardHeatValueData.New(v))
	end
end

return FightCardHeatInfoData
