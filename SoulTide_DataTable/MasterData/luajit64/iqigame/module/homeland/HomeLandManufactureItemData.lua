-- chunkname: @IQIGame\\Module\\HomeLand\\HomeLandManufactureItemData.lua

HomeLandManufactureItemData = {
	isLock = false
}

function HomeLandManufactureItemData.New()
	local o = Clone(HomeLandManufactureItemData)

	return o
end

function HomeLandManufactureItemData:Init(id)
	self.cid = id
	self.cfgManufactureItem = CfgHomeLandManufactureItemTable[id]
end

function HomeLandManufactureItemData:UpdateUnLock(isLock)
	self.isLock = isLock
end

function HomeLandManufactureItemData:IsCanMake()
	local top = true

	for i = 1, #self.cfgManufactureItem.NeedItem, 2 do
		local id = self.cfgManufactureItem.NeedItem[i]
		local needNum = self.cfgManufactureItem.NeedItem[i + 1]
		local haveNum = WarehouseModule.GetItemNumByCfgID(id)

		top = top and needNum <= haveNum
	end

	top = top and self.isLock

	return top
end

function HomeLandManufactureItemData:HaveNumber()
	local num = 0
	local itemID = self.cfgManufactureItem.GetItem
	local bagNum = WarehouseModule.GetItemNumByCfgID(itemID)
	local decorateCid

	for i, v in pairsCfg(CfgHomeLandDecorateTable) do
		if v.Item == itemID then
			decorateCid = v.Id

			break
		end
	end

	local putInRoomNum = 0

	if decorateCid then
		putInRoomNum = HomeLandLuaModule.GetDecorateNumByCid(decorateCid)
	end

	num = bagNum + putInRoomNum

	return num
end

return HomeLandManufactureItemData
