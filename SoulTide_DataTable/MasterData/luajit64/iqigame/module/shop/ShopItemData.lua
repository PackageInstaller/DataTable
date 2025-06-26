-- chunkname: @IQIGame\\Module\\Shop\\ShopItemData.lua

ShopItemData = {
	freeRefreshCnt = -1,
	id = 0,
	itemRefreshCnt = -1,
	nextRefreshTime = -1,
	payRefreshCnt = -1,
	cid = -1,
	goodsList = {},
	buyGoodsList = {}
}

function ShopItemData.New(ShopItemData)
	local ItemData = Clone(ShopItemData)

	for key, value in pairs(ShopItemData) do
		ItemData[key] = value
	end

	return ItemData
end

function ShopItemData.NewMazeShopData(MazeShopData)
	local ShopData = Clone(ShopItemData)

	ShopData.cid = MazeShopData.CID
	ShopData.goodsList = MazeShopData.GoodsList
	ShopData.buyGoodsList = MazeShopData.BuyGoodsList
	ShopData.freeRefreshCnt = MazeShopData.FreeRefreshCnt
	ShopData.itemRefreshCnt = MazeShopData.ItemRefreshCnt
	ShopData.payRefreshCnt = MazeShopData.PayRefreshCnt
	ShopData.id = MazeShopData.ID

	return ShopData
end
