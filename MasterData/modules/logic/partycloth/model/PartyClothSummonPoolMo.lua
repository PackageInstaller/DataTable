-- chunkname: @modules/logic/partycloth/model/PartyClothSummonPoolMo.lua

module("modules.logic.partycloth.model.PartyClothSummonPoolMo", package.seeall)

local PartyClothSummonPoolMo = pureTable("PartyClothSummonPoolMo")

function PartyClothSummonPoolMo:init(info)
	self.poolId = info.poolId
	self.hasSummonPrizeInfos = info.hasSummonPrizeInfos
	self.leftPrizeNum = info.leftPrizeNum
end

function PartyClothSummonPoolMo:update(hasSummonPrizeInfos, leftPrizeNum)
	self.hasSummonPrizeInfos = hasSummonPrizeInfos
	self.leftPrizeNum = leftPrizeNum
end

return PartyClothSummonPoolMo
