-- chunkname: @IQIGame\\Module\\Shop\\ShopModule_MazeShop.lua

local this = ShopModule

function this.GetMazeShopLevel()
	return MazeModule.GetShopLevel()
end

function this.GetMazeShopMaxLevel()
	if this.__mazeShopMaxLevel == nil then
		this.__mazeShopMaxLevel = getCfgTableLength(CfgLabyrinthMarketLevelTable)
	end

	return this.__mazeShopMaxLevel
end

function this.GetMazeShopLevelConfig(level)
	return CfgLabyrinthMarketLevelTable[level]
end

function this.GetMazeShopItemList()
	local items = {}
	local allShopItems = this.GetAllItemsWithShopType(Constant.ShopType.MazeShop.Type)

	for _, _shopCommodityData in pairs(allShopItems) do
		if ConditionModule.Check(_shopCommodityData.config.UnlockConditionId) then
			table.insert(items, _shopCommodityData)
		end
	end

	table.sort(items, function(item1, item2)
		return item1.config.sort < item2.config.sort
	end)

	return items
end

function this.GetMazeShopCid()
	return Constant.ShopType.MazeShop.ShopCid
end
