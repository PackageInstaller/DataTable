-- chunkname: @modules/logic/battlepass/model/BpBonusMO.lua

module("modules.logic.battlepass.model.BpBonusMO", package.seeall)

local BpBonusMO = pureTable("BpBonusMO")

function BpBonusMO:init(info)
	self.id = info.level
	self.level = info.level
	self.hasGetfreeBonus = info.hasGetfreeBonus
	self.hasGetPayBonus = info.hasGetPayBonus
	self.hasGetSpfreeBonus = info.hasGetSpfreeBonus
	self.hasGetSpPayBonus = info.hasGetSpPayBonus
end

function BpBonusMO:updateServerInfo(info)
	if info:HasField("hasGetfreeBonus") then
		self.hasGetfreeBonus = info.hasGetfreeBonus
	end

	if info:HasField("hasGetPayBonus") then
		self.hasGetPayBonus = info.hasGetPayBonus
	end

	if info:HasField("hasGetSpfreeBonus") then
		self.hasGetSpfreeBonus = info.hasGetSpfreeBonus
	end

	if info:HasField("hasGetSpPayBonus") then
		self.hasGetSpPayBonus = info.hasGetSpPayBonus
	end
end

return BpBonusMO
