-- chunkname: @IQIGame\\Module\\HomeLandManufacture\\ManufactureDecomposeItemData.lua

ManufactureDecomposeItemData = {
	themeID = 0
}

function ManufactureDecomposeItemData.New(cfgItemCid)
	local o = Clone(ManufactureDecomposeItemData)

	o:Init(cfgItemCid)

	return o
end

function ManufactureDecomposeItemData:Init(cfgItemCid)
	self.cfgItemCid = cfgItemCid
end

return ManufactureDecomposeItemData
