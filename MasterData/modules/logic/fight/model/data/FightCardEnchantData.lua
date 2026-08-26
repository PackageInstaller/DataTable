-- chunkname: @modules/logic/fight/model/data/FightCardEnchantData.lua

module("modules.logic.fight.model.data.FightCardEnchantData", package.seeall)

local FightCardEnchantData = FightDataClass("FightCardEnchantData")

function FightCardEnchantData:onConstructor(proto)
	self.enchantId = proto.enchantId
	self.duration = proto.duration
	self.exInfo = {}

	for index, value in ipairs(proto.exInfo) do
		table.insert(self.exInfo, value)
	end
end

return FightCardEnchantData
