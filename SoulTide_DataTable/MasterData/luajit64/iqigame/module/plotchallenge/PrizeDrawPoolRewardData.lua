-- chunkname: @IQIGame\\Module\\PlotChallenge\\PrizeDrawPoolRewardData.lua

local m = {}

function m.New(prizeDrawPoolId, id, itemNum, currentItemTime, itemTime, itemWeight, itemQuality)
	local o = Clone(m)

	o:Init(prizeDrawPoolId, id, itemNum, currentItemTime, itemTime, itemWeight, itemQuality)

	return o
end

function m:Init(prizeDrawPoolId, id, itemNum, currentItemTime, itemTime, itemWeight, itemQuality)
	self.PrizeDrawPoolId = prizeDrawPoolId
	self.Id = id
	self.ItemNum = itemNum
	self.ItemTime = itemTime
	self.CurrentItemTime = currentItemTime
	self.ItemWeight = itemWeight
	self.ItemQuality = itemQuality
end

return m
