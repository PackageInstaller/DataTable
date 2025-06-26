-- chunkname: @IQIGame\\Module\\Shop\\ShopModule.lua

ShopModule = {}
ShopModule.AllShopsArr = {}

function ShopModule.Reload(items)
	ShopModule.AllShopsArr = {}

	for i, v in pairs(items) do
		ShopModule.AllShopsArr[i] = ShopItemData.New(v)
	end
end

function ShopModule.updateShopItem(shopItems)
	local has = false

	for i = 1, #ShopModule.AllShopsArr do
		if ShopModule.AllShopsArr[i].cid == shopItems.cid then
			ShopModule.AllShopsArr[i] = ShopItemData.New(shopItems)

			EventDispatcher.Dispatch(EventID.ShopUpdate, ShopModule.AllShopsArr[i].cid)

			has = true

			break
		end
	end

	if has == false then
		local len = #ShopModule.AllShopsArr + 1

		ShopModule.AllShopsArr[len] = ShopItemData.New(shopItems)

		EventDispatcher.Dispatch(EventID.ShopUpdate, ShopModule.AllShopsArr[len].cid)
	end
end

function ShopModule.GetShopDataByShopId(shopId)
	for i = 1, #ShopModule.AllShopsArr do
		if ShopModule.AllShopsArr[i].cid == shopId then
			return ShopModule.AllShopsArr[i]
		end
	end

	return nil
end

function ShopModule.CheckExistShop(shopId)
	return ShopModule.GetShopDataByShopId(shopId) ~= nil
end

function ShopModule.GetShopItemDataByItemId(CfgItemData)
	local shopItemData = {}

	shopItemData.cid = CfgItemData.Id
	shopItemData.num = 1
	shopItemData.usedNum = CfgItemData.UsedNum
	shopItemData.Type = CfgItemData.Type
	shopItemData.PAbilities = CfgItemData.RandPAbility

	return CfgItemData
end

function ShopModule.SendBuyMsg(shopCid, goodsIndex)
	net_shop.buy(shopCid, goodsIndex)
end

function ShopModule.ResponseBuyItemMsg(shopCid, index)
	NoticeModule.ShowNotice(21040017)
	EventDispatcher.Dispatch(EventID.BuyShopItemEvent, shopCid)
end

function ShopModule.SendRefreshMsg(shopCid, refreshType)
	net_shop.refresh(shopCid, refreshType)
end
