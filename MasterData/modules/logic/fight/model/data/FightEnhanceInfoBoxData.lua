-- chunkname: @modules/logic/fight/model/data/FightEnhanceInfoBoxData.lua

module("modules.logic.fight.model.data.FightEnhanceInfoBoxData", package.seeall)

local FightEnhanceInfoBoxData = FightDataClass("FightEnhanceInfoBoxData")

function FightEnhanceInfoBoxData:onConstructor(proto)
	self.uid = proto.uid
	self.canUpgradeIds = {}
	self.upgradedOptions = {}

	for i, v in ipairs(proto.canUpgradeIds) do
		table.insert(self.canUpgradeIds, v)
	end

	for i, v in ipairs(proto.upgradedOptions) do
		table.insert(self.upgradedOptions, v)
	end
end

return FightEnhanceInfoBoxData
