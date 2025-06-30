-- chunkname: @IQIGame\\Module\\FurnitureLottery\\FurnitureLotteryData.lua

FurnitureLotteryData = {}

function FurnitureLotteryData.New(cfgID, open, endDateTime)
	local o = Clone(FurnitureLotteryData)

	o:Init(cfgID, open, endDateTime)

	return o
end

function FurnitureLotteryData:Init(cfgID, open, endDateTime)
	self.cfgID = cfgID
	self.cfgInfo = CfgLotteryShowTable[cfgID]
	self.open = open
	self.endDateTime = endDateTime
end

return FurnitureLotteryData
