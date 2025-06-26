-- chunkname: @IQIGame\\Module\\FurnitureLottery\\DecorateIllustrationsData.lua

DecorateIllustrationsData = {}

function DecorateIllustrationsData.New(cfgID, activation)
	local o = Clone(DecorateIllustrationsData)

	o:Init(cfgID, activation)

	return o
end

function DecorateIllustrationsData:Init(cfgID, activation)
	self.cfgID = cfgID
	self.cfgInfo = CfgHomeLandDecorateTable[cfgID]
	self.cfgItemID = self.cfgInfo.Item
	self.activation = activation
end

return DecorateIllustrationsData
