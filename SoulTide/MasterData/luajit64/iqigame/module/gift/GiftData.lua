-- chunkname: @IQIGame\\Module\\Gift\\GiftData.lua

GiftData = {}

function GiftData.New()
	local o = Clone(GiftData)

	return o
end

function GiftData:Init(id)
	self.Id = id
	self.cfgGiftInfo = CfgGiftTable[id]
	self.quality = CfgItemTable[self.cfgGiftInfo.ItemId].Quality
end
