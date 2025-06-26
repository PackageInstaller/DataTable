-- chunkname: @IQIGame\\Module\\BuyPanel\\BuyGoodsData.lua

BuyGoodsData = {
	ContainNum = 0,
	ItemCid = -1,
	ShopType = 0,
	Price = 0,
	CountDownTime = -1,
	PriceIconID = 0,
	StartTime = -1
}

function BuyGoodsData.New()
	local ItemData = Clone(BuyGoodsData)

	return ItemData
end
